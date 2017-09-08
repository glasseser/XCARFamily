//
//  SourceTool.m
//  car_video
//
//  Created by custom on 16/12/21.
//  Copyright © 2016年 self. All rights reserved.
//

#import "SourceTool.h"

#define ControllerContentCollectionViewCellIdentifier @"ControllerContent_CollectionViewCell_Identifier"

@interface SourceTool ()

@end

@implementation SourceTool

/**
 根据控制器的前缀名称获取重用标识名
 
 @param VCName 控制器的前缀名称
 @return cell的重用标识名
 */
+ (NSString *)getCellrEeuseIdentifierNameWith:(NSString *)VCName {
    return [[NSString alloc] initWithFormat:@"%@_%@",VCName,ControllerContentCollectionViewCellIdentifier];
}

/**
 获取全部的重用标识名字
 
 @return 返回重用标识数组
 */
+ (NSArray *)getAllControllerContentCellIdentifierName {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"CategoryVC" ofType:@"plist"];
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:filePath];
    NSArray *array = [dict allValues];
    NSMutableArray *mul_arr = [NSMutableArray arrayWithCapacity:array.count];
    for (NSString *vc_name in array) {
        [mul_arr addObject:[[NSString alloc] initWithFormat:@"%@_%@",vc_name,ControllerContentCollectionViewCellIdentifier]];
    }
    return [mul_arr copy];
}

/**
 根据关键字获取控制器的类名
 
 @param key 关键字
 @return 控制器的类名
 */
+ (NSString *)getControllerClassNameWith:(NSString *)key {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"CategoryVC" ofType:@"plist"];
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:filePath];
    return [dict objectForKey:key];
}


#pragma mark - 归档相关
+ (void)updateObjectAbout_Obj:(id)aObj
                         name:(NSString *)name {
    //登录成功，沙盒中保存账号
    NSString *documents = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *path = [NSString stringWithFormat:@"%@/%@.archive",documents,name];
    NSLog(@"归档路径: %@",path);
    
    BOOL isSuccezzed = [NSKeyedArchiver archiveRootObject:aObj toFile:path];
    if (isSuccezzed){
        
    }else{
        NSLog(@"保存沙盒失败!!!");
    }
}

+ (id)unArchierAboutObjWithName:(NSString *)name {
    NSString *documents = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *path = [NSString stringWithFormat:@"%@/%@.archive",documents,name];
    id des_obj = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    NSLog(@"接档路径:%@",path);
    return des_obj;
}

#pragma mark - 懒加载和单例
- (NSMutableArray *)otherSource {
    NSMutableArray *mul_array = [SourceTool unArchierAboutObjWithName:@"Recommend_Other_Info"];
    if (!mul_array) {
        if (!_otherSource){
            _otherSource = [@[] mutableCopy];
        }
    }else{
        if (!_otherSource) {
            _otherSource = [mul_array mutableCopy];
        }
    }
    return _otherSource;
}

- (NSMutableArray *)getChoiceSource {
    NSMutableArray *array = [self.choiceSource mutableCopy];
    [array removeObject:@"推荐"];
    return array;
}

- (NSMutableArray *)choiceSource {
    //暂时默认这样写 , @"推荐" ,"推荐"模块是一定有的
    NSMutableArray *mul_array = [SourceTool unArchierAboutObjWithName:@"Recommend_Choice_Info"];
    if (!mul_array) {
        if (!_choiceSource) {
            NSString *filePath = [[NSBundle mainBundle] pathForResource:@"CategoryVC" ofType:@"plist"];
            NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:filePath];
            NSArray *array = [dict allKeys];
            _choiceSource = [array mutableCopy];
        }
    }else{
        if (!_choiceSource) {
            _choiceSource = [mul_array mutableCopy];
        }
    }
    return _choiceSource;
}

+ (instancetype)shareTool {
    static id instance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instance = [[self alloc]init];
    });
    return instance;
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
    });
    return instance;
}

@end

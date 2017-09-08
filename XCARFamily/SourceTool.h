//
//  SourceTool.h
//  car_video
//
//  Created by custom on 16/12/21.
//  Copyright © 2016年 self. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SourceTool : NSObject

/**
 * 该属性主要是用于记录已经选择的频道，每一次刷新数组都应该在沙盒中保存一份，每当程序运行，从沙盒中获取相应的资源
 */
@property (nonatomic , strong) NSMutableArray *choiceSource;

/**
 * 该属性是记录着没有选择的频道
 */
@property (nonatomic , strong) NSMutableArray *otherSource;


+ (instancetype)shareTool;
- (id)copyWithZone:(NSZone *)zone;
+ (instancetype)allocWithZone:(struct _NSZone *)zone;

/**
 根据控制器的前缀名称获取重用标识名

 @param VCName 控制器的前缀名称
 @return cell的重用标识名
 */
+ (NSString *)getCellrEeuseIdentifierNameWith:(NSString *)VCName;

/**
 获取全部的重用标识名字

 @return 返回重用标识数组
 */
+ (NSArray *)getAllControllerContentCellIdentifierName;


/**
 根据关键字获取控制器的类名

 @param key 关键字
 @return 控制器的类名
 */
+ (NSString *)getControllerClassNameWith:(NSString *)key;


- (NSMutableArray *)getChoiceSource;
#pragma mark - 归档相关
+ (void)updateObjectAbout_Obj:(id)aObj
                         name:(NSString *)name;
//解档
+ (id)unArchierAboutObjWithName:(NSString *)name;




@end

 //
//  focusImg_Model.m
//  car_video
//
//  Created by custom on 16/12/17.
//  Copyright © 2016年 self. All rights reserved.
//

#import "focusImg_Model.h"
#import <objc/runtime.h>

@implementation focusImg_Model

//获取当前的类的属性的名字，将名字存进数组中
+ (NSArray *)properties
{
    //数量
    unsigned int count = 0;
    //获取该类的所有的属性，返回的指向数组的指向
    objc_property_t *list =class_copyPropertyList([self class], &count);
    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i < count; ++i){
        //根据i获取对应的属性
        objc_property_t p = list[i];
        const char *cname = property_getName(p);
        //将属性添加到数组中
        [arrayM addObject:[NSString stringWithUTF8String:cname]];
    }
    return arrayM.copy;
}


+ (instancetype)carWithDict:(NSDictionary *)dic
{
    id obj = [[self alloc]init];
    NSArray *properties = [focusImg_Model properties];//返回存储着类属性名字的数组
    for (NSString *pro in properties){
        //判断你获取到的数组中的属性的值是否为空
        if (dic[pro] != nil && ![dic[pro] isKindOfClass:[NSNull class]]){
            [obj setValue:dic[pro] forKey:pro];
        }
    }
    return obj;
}

+ (NSMutableArray *)dataSourceWithDict:(NSDictionary *)dict key:(NSString *)keyString
{
    NSDictionary *sourceDatDict = [dict objectForKey:@"sourceData"];
    NSDictionary *resultDict = [sourceDatDict objectForKey:@"result"];
    NSArray *array = [resultDict objectForKey:keyString];
    
    NSMutableArray *sourceArray = [NSMutableArray array];
    for (NSDictionary *dict in array){
        focusImg_Model *model = [self carWithDict:dict];
        [sourceArray addObject:model];
    }
    return [sourceArray copy];
}

@end

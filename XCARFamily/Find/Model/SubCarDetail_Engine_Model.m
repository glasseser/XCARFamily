//
//  SubCarDetail_Engine_Model.m
//  CARFamily
//
//  Created by imac on 2017/8/29.
//  Copyright © 2017年 GuangZhouWeiControl. All rights reserved.
//

#import "SubCarDetail_Engine_Model.h"
#import "SubCarDetail_Cars_Model.h"

@implementation SubCarDetail_Engine_Model

+ (instancetype)ModelWithDict:(NSDictionary *)dic {
    
    id obj = [[self alloc]init];
    NSArray *properties = [self properties];//返回存储着类属性名字的数组
    for (NSString *pro in properties) {
        //判断你获取到的数组中的属性的值是否为空
        if (dic[pro] != nil && ![dic[pro] isKindOfClass:[NSNull class]]) {
            if ([pro isEqualToString:@"cars"]) {
                NSMutableArray *array = [NSMutableArray array];
                for (NSDictionary *dict in dic[pro]) {
                    SubCarDetail_Cars_Model *model = [SubCarDetail_Cars_Model ModelWithDict:dict];
                    [array addObject:model];
                }
                [obj setValue:[array copy] forKey:pro];
                continue;
            }
            [obj setValue:dic[pro] forKey:pro];
        }
    }
    return obj;
}

@end

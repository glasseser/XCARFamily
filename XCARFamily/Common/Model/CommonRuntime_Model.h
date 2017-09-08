//
//  CommonRuntime_Model.h
//  car_video
//
//  Created by imac on 2017/8/25.
//  Copyright © 2017年 self. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonRuntime_Model : NSObject

+ (NSArray *)properties;
+ (instancetype)ModelWithDict:(NSDictionary *)dic;
+ (NSMutableArray *)dataSourceWithDict:(NSDictionary *)dict key:(NSString *)keyString;

@end

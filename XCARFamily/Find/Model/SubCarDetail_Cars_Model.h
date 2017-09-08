//
//  SubCarDetail_Cars_Model.h
//  CARFamily
//
//  Created by imac on 2017/8/29.
//  Copyright © 2017年 GuangZhouWeiControl. All rights reserved.
//

#import "CommonRuntime_Model.h"

/*
 {
 "carId": 35336,
 "carName": "35 TFSI 风尚型",
 "subSeriesId": "8613",
 "subSeriesName": "2017款奥迪A3两厢",
 "guidePrice": "23.25 万",
 "engine": "1.4T",
 "transmission": "双离合变速箱",
 "driver": "前置前驱",
 "lowestPrice": "23.25 万"
 }
 */

@interface SubCarDetail_Cars_Model : CommonRuntime_Model

@property (nonatomic , assign) long carId;
@property (nonatomic , strong) NSString *carName; //车辆名称
@property (nonatomic , strong) NSString *subSeriesId;
@property (nonatomic , strong) NSString *subSeriesName;//标题
@property (nonatomic , strong) NSString *guidePrice;//参考价格
@property (nonatomic , strong) NSString *engine; //引擎
@property (nonatomic , strong) NSString *transmission; //离合
@property (nonatomic , strong) NSString *driver;//驱动
@property (nonatomic , strong) NSString *lowestPrice; //最低价格



@end

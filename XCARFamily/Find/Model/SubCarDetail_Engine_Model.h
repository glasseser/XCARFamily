//
//  SubCarDetail_Engine_Model.h
//  CARFamily
//
//  Created by imac on 2017/8/29.
//  Copyright © 2017年 GuangZhouWeiControl. All rights reserved.
//

#import "CommonRuntime_Model.h"

/*
 "engine": "1.4T",
 "cars": [
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
 ]
 */

@interface SubCarDetail_Engine_Model : CommonRuntime_Model

@property (nonatomic , strong) NSString *engine;
@property (nonatomic , strong) NSArray *cars;


@end

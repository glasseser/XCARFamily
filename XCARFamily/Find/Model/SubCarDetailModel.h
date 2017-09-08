//
//  SubCarDetailModel.h
//  CARFamily
//
//  Created by imac on 2017/8/29.
//  Copyright © 2017年 GuangZhouWeiControl. All rights reserved.
//

#import "CommonRuntime_Model.h"

/*
 {
 "seriesName": "奥迪A3两厢",
 "brandName": "一汽-大众奥迪",
 "levelName": "紧凑型车",
 "clubId": 738,
 "price": "18.8-24.95万",
 "transactionPrice": "",
 "image": "http://img1.xcarimg.com/b5/s8613/m_20170728221150798138529694547.jpg",
 "isFavorited": 0,
 "webLink": "http://newcar.xcar.com.cn/2365",
 "imageCount": 3619,
 "saleSubSeries": [
 {
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
 },
 ],
 "imageColor": []
 }
 */

@interface SubCarDetailModel : CommonRuntime_Model

@property (nonatomic , strong) NSString *seriesName;
@property (nonatomic , strong) NSString *brandName;
@property (nonatomic , strong) NSString *levelName;
@property (nonatomic , assign) long clubId;
@property (nonatomic , strong) NSString *price;
@property (nonatomic , strong) NSString *transactionPrice;
@property (nonatomic , strong) NSString *image;
@property (nonatomic , assign) BOOL isFavorited;
@property (nonatomic , strong) NSString *webLink;
@property (nonatomic , assign) long imageCount;
@property (nonatomic , strong) NSArray *saleSubSeries;
@property (nonatomic , strong) NSArray *imageColor;



@end

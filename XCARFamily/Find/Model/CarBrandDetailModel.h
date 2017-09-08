//
//  CarBrandDetailModel.h
//  CARFamily
//
//  Created by imac on 2017/8/29.
//  Copyright © 2017年 GuangZhouWeiControl. All rights reserved.
//

#import "CommonRuntime_Model.h"

/*
 {
 clubId = 737;
 isSale = 1;
 seriesIcon = "http://img1.xcarimg.com/PicLib/spng/s6532_180.png?t=20170829";
 seriesId = 575;
 seriesName = "\U5965\U8feaA1";
 seriesPrice = "20.48-23.48\U4e07";
 }
 */

@interface CarBrandDetailModel : CommonRuntime_Model

@property (nonatomic , assign) NSInteger clubId;
@property (nonatomic , assign) BOOL isSale; //是否在售
@property (nonatomic , strong) NSString *seriesIcon;
@property (nonatomic , assign) long seriesId;
@property (nonatomic , strong) NSString *seriesName;
@property (nonatomic , strong) NSString *seriesPrice;

@end

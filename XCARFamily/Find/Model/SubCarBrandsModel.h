//
//  SubCarBrandsModel.h
//  CARFamily
//
//  Created by imac on 2017/8/29.
//  Copyright © 2017年 GuangZhouWeiControl. All rights reserved.
//

#import "CommonRuntime_Model.h"
@class CarBrandDetailModel;

@interface SubCarBrandsModel : CommonRuntime_Model

@property (nonatomic , strong) NSArray<NSDictionary *> *series;//@"sales",@"unSales"
@property (nonatomic , assign) NSInteger seriesNum;
@property (nonatomic , assign) NSInteger subBrandId;
@property (nonatomic , strong) NSString *subBrandName;

@end

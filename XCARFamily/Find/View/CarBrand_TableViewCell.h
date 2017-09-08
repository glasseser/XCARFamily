//
//  CarBrand_TableViewCell.h
//  CARFamily
//
//  Created by imac on 2017/8/29.
//  Copyright © 2017年 GuangZhouWeiControl. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CarBrandDetailModel;

@interface CarBrand_TableViewCell : UITableViewCell

- (void)bindModel:(CarBrandDetailModel *)model;

@end

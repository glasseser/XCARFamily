//
//  SubCarDetail_TableViewCell.h
//  CARFamily
//
//  Created by imac on 2017/8/31.
//  Copyright © 2017年 GuangZhouWeiControl. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SubCarDetail_Cars_Model;

@interface SubCarDetail_TableViewCell : UITableViewCell

- (void)bindModel:(SubCarDetail_Cars_Model *)model;

@end

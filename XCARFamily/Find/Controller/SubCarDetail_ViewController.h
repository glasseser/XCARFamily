//
//  SubCarDetail_ViewController.h
//  CARFamily
//
//  Created by imac on 2017/8/29.
//  Copyright © 2017年 GuangZhouWeiControl. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SubCarDetailModel;

@interface SubCarDetail_ViewController : UIViewController

@property (nonatomic , strong) NSString *urlString;
@property (nonatomic , strong) UITableView *tableView;
@property (nonatomic , strong) NSMutableArray *DataSources;
@property (nonatomic , strong) SubCarDetailModel *model;

@end

//
//  SubCar_ViewController.h
//  car_video
//
//  Created by imac on 2017/8/28.
//  Copyright © 2017年 self. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CarBrandModel;

@interface SubCar_ViewController : UIViewController
@property (nonatomic , strong) UITableView *tableView;
@property (nonatomic , strong) NSMutableArray *DataSources;

- (instancetype)initWithModel:(CarBrandModel *)model;

@end

//
//  Find_ViewController.h
//  car_video
//
//  Created by custom on 16/12/9.
//  Copyright © 2016年 self. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Find_ViewController : UIViewController

@property (nonatomic , strong) UITableView *tableView;
@property (nonatomic , weak) UILabel *tipNullTxt;
@property (nonatomic , strong) NSArray *datasources;
@property (nonatomic , strong) NSArray *titles;

@end

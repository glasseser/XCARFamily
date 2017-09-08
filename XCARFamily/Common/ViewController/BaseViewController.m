//
//  BaseViewController.m
//  car_video
//
//  Created by custom on 16/12/22.
//  Copyright © 2016年 self. All rights reserved.
//

#import "BaseViewController.h"
#import "navigationTop_TipBar.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    _VCNameLabel = [[UILabel alloc] init];
    _VCNameLabel.textColor = [UIColor blackColor];
    [self.view addSubview:_VCNameLabel];
    [_VCNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.offset(0);
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    UIViewController *parant_vc = [self parentViewController];
    for (UIView *sub_view in parant_vc.navigationController.navigationBar.subviews) {
        if ([sub_view isKindOfClass:[navigationTop_TipBar class]]) {
            sub_view.hidden = NO;
            break;
        }
    }
    self.tabBarController.tabBar.hidden = NO;
}

@end

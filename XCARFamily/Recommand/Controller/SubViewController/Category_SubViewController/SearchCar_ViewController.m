//
//  SearchCar_ViewController.m
//  car_video
//
//  Created by custom on 16/12/20.
//  Copyright © 2016年 self. All rights reserved.
//

#import "SearchCar_ViewController.h"

@interface SearchCar_ViewController ()

@end

@implementation SearchCar_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initOpacity];
    [self setupSubViews];
}

- (void)initOpacity
{
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)setupSubViews
{
    UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width-60, 20, 60, 44)];
    [self.view addSubview:closeBtn];
    [closeBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [closeBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [closeBtn setTitle:@"关闭" forState:UIControlStateNormal];
    closeBtn.tag = 1;
}

- (void)btnClick:(UIButton *)btn
{
    if (btn.tag == 1){
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end

//
//  MessageDetailWeb_ViewController.h
//  car_video
//
//  Created by imac on 2017/8/25.
//  Copyright © 2017年 self. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageDetailWeb_ViewController : UIViewController

@property (nonatomic , strong) UILabel *titleLabel;//标题
@property (nonatomic , strong) UIButton *backButton;//返回按钮

- (void)loadMsgWithURL:(NSString *)url;

- (instancetype)initWithTitle:(NSString *)title;

@end

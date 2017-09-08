//
//  LoadingView_TypeOne.h
//  CARFamily
//
//  Created by imac on 2017/8/30.
//  Copyright © 2017年 GuangZhouWeiControl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingView_TypeOne : UIView

@property (nonatomic , strong) UIColor *borderColor;  //108 108 108
@property (nonatomic , strong) UIColor *txtColor;  //108 108 108
@property (nonatomic , strong) UIColor *dotHighLightColor;//151 151 151
@property (nonatomic , strong) UIColor *dotNormalColor;  //78 78 78
@property (nonatomic , strong) UIFont *txtFont;
@property (nonatomic , assign) CGFloat BorderWidth;
@property (nonatomic , assign) CGFloat BorderHeight;
@property (nonatomic , strong) NSString *txt;

- (instancetype)initWithView:(UIView *)superView;
- (instancetype)initWithWindow:(UIWindow *)win;

- (void)show:(BOOL)isShow;
- (void)hide:(BOOL)isHide;

@end

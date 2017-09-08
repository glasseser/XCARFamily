//
//  UIView+ScreenShot.h
//  car_video
//
//  Created by custom on 16/12/21.
//  Copyright © 2016年 self. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ScreenShot)

- (UIImage *)screenshot;
- (UIImage *)screenshotWithRect:(CGRect)rect;

@end

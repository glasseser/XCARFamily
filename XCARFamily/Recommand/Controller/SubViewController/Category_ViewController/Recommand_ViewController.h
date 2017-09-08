//
//  Recommand_ViewController.h
//  car_video
//
//  Created by custom on 16/12/9.
//  Copyright © 2016年 self. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Recommand_ViewController : BaseViewController

/**
 * 当前正在使用的控制器
 */
@property (nonatomic , assign) NSInteger currentChoice_ViewController;

@property (nonatomic , weak) UILabel *tipNullTxt;

@end

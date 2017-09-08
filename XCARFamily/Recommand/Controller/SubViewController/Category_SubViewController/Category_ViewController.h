//
//  Category_ViewController.h
//  car_video
//
//  Created by custom on 16/12/20.
//  Copyright © 2016年 self. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Category_ViewController;
@protocol Category_ViewControllerDelegate <NSObject>

@optional
- (void)Category_ViewController:(Category_ViewController *)vc didFinishedChooseCategory:(NSDictionary *)dict;

@end

@interface Category_ViewController : UIViewController

@property (nonatomic , weak) id<Category_ViewControllerDelegate> delegate;

- (void)showActionAnimation;

@end

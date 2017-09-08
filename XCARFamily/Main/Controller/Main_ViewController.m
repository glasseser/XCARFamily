//
//  Main_ViewController.m
//  car_video
//
//  Created by custom on 16/12/9.
//  Copyright © 2016年 self. All rights reserved.
//

#import "Main_ViewController.h"

#import "Recommand_ViewController.h"

#import "Newlist_ViewController.h"

#import "Forum_ViewController.h"
#import "Find_ViewController.h"
#import "Car_ViewController.h"
#import "Me_ViewController.h"

@interface Main_ViewController ()

@end

@implementation Main_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initOpacity];
}

- (void)initOpacity{
    [self prepareControllers];
}

- (void)prepareControllers{
    
    Recommand_ViewController *recommandVC = [[Recommand_ViewController alloc] init];
    Newlist_ViewController *newListVC = [[Newlist_ViewController alloc] initWithBaseViewController:recommandVC];
    Forum_ViewController *forumVC = [[Forum_ViewController alloc] init];
    Find_ViewController *findVC = [[Find_ViewController alloc] init];
    Car_ViewController *carVC = [[Car_ViewController alloc] init];
    Me_ViewController *meVC = [[Me_ViewController alloc] init];
    
    [self addChildViewController:newListVC imageName:@"item01"];
    [self addChildViewController:forumVC imageName:@"item02"];
    [self addChildViewController:findVC imageName:@"item03"];
    [self addChildViewController:carVC imageName:@"item04"];
    [self addChildViewController:meVC imageName:@"item05"];
}

- (void)addChildViewController:(UIViewController *)childController imageName:(NSString *)imageName
{
    UIImage *selectedImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",imageName]];
    
    [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [childController setTabBarItem:[[UITabBarItem alloc] initWithTitle:nil image:[UIImage imageNamed:imageName] selectedImage:selectedImage]];
    
    //让图片垂直
    CGFloat imageOffset = 5.0;
    childController.tabBarItem.imageInsets = UIEdgeInsetsMake(imageOffset, 0, -imageOffset, 0);
    UINavigationController *navCtrl = [[UINavigationController alloc]initWithRootViewController:childController];
    [self addChildViewController:navCtrl];
}

@end

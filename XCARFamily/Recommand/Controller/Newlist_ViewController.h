//
//  Newlist_ViewController.h
//  car_video
//
//  Created by custom on 16/12/22.
//  Copyright © 2016年 self. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Newlist_ViewController : UIViewController

//@property (nonatomic , weak) UICollectionView *collectionView;
//@property (nonatomic , strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic , strong) UIScrollView *scrollView;
@property (nonatomic , strong) BaseViewController *baseVC;

@property (nonatomic , assign) NSInteger currentPage;//当前页数
@property (nonatomic , strong) NSMutableDictionary *controllerCache;//控制器缓存

- (instancetype)initWithBaseViewController:(BaseViewController *)baseVC;
- (void)setTopBarHide:(BOOL)hide;

@end

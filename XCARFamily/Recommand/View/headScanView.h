//
//  headScanView.h
//  car_video
//
//  Created by custom on 16/12/17.
//  Copyright © 2016年 self. All rights reserved.
//

#import <UIKit/UIKit.h>

@class headScanView,focusImg_Model;
@protocol headScanViewDelegate <NSObject>

@required
- (NSString *)HeadScanView:(headScanView *)scanView
     URLForItemAtIndexPath:(NSIndexPath *)indexPath;

@optional
- (void)collectionViewImgDidSelected:(NSIndexPath *)indexPath focusImgModel:(id)model;
- (NSInteger)numberOfSectionsInHeadScanView:(headScanView *)scanView;
- (NSInteger)HeadScanView:(headScanView *)scanView
   numberOfItemsInSection:(NSInteger)section;

@end

@interface headScanView : UIView

@property (nonatomic , weak) UICollectionView *collectionView;
@property (nonatomic , strong) UICollectionViewFlowLayout *layout;
@property (nonatomic , weak) UIPageControl *pageControl;
@property (nonatomic , weak) id<headScanViewDelegate> delegate;
@property (nonatomic , assign) NSInteger Count;


- (void)dataSourceFrom:(NSArray *)dataSource;
- (void)beginScroll;
- (void)endScroll;
- (void)initOpacity;
- (NSArray *)dataSources;
- (void)reloadData;

@end

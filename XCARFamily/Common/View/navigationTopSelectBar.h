//
//  navigationTopSelectBar.h
//  CARFamily
//
//  Created by imac on 2017/8/29.
//  Copyright © 2017年 GuangZhouWeiControl. All rights reserved.
//

#import <UIKit/UIKit.h>

@class recommandTop_CollectionViewCell,navigationTopSelectBar;

//代理
@protocol navigationTopSelectBar <NSObject>

@required
//数据源
- (NSInteger)numberOfSectionsInNavigationTopSelectBar:(navigationTopSelectBar *)topBar;
- (NSInteger)navigationTopSelectBar:(navigationTopSelectBar *)topBar
             numberOfItemsInSection:(NSInteger)section;
- (NSString *)navigationTopSelectBar:(navigationTopSelectBar *)topBar contentForItemAtIndexPath:(NSIndexPath *)indexPath;

@optional
- (void)navigationTopSelectBar:(navigationTopSelectBar *)bar btnClick:(UIButton *)btn;
- (void)navigationTopSelectBar:(navigationTopSelectBar *)bar didSeledtedCellForIndexPath:(NSIndexPath *)indexPath;
- (void)navigationTopSelectBar:(navigationTopSelectBar *)bar didSeledtedCellForIndexPath:(NSIndexPath *)indexPath Name:(NSString *)name;

@end

@interface navigationTopSelectBar : UIView

@property (nonatomic , weak) NSIndexPath *currentChoiceIndexPath;//当前选择的cell的indexPath , 还有一个是下一次选择的indexPath
@property (nonatomic , strong) NSIndexPath *preChoiceIndexPath;//上一次cell选中的indexPath
@property (nonatomic , weak) id delegate;

@property (nonatomic , weak) UICollectionView *collectionView;
@property (nonatomic , strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic , assign) CGSize itemSize;
@property (nonatomic , assign) NSInteger vistualItems;

//栏目下方的跟踪视图
@property (nonatomic , weak) UIView *followView;

- (void)setupSubViews;
- (void)setupOtherActions:(void (^)())otherAction;
- (void)reloadData;
- (void)selectCell:(NSIndexPath *)indexPath;

@end

//
//  navigationTop_TipBar.h
//  car_video
//
//  Created by custom on 16/12/19.
//  Copyright © 2016年 self. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    KNavigationTopBarActionType_back         = 11,//后
    KNavigationTopBarActionType_equal,            //不变
    KNavigationTopBarActionType_pre,              //前
    KNavigationTopBarActionType_unknow,           //未知
} KNavigationTopBarActionType;

@class recommandTop_CollectionViewCell,navigationTop_TipBar;

//代理
@protocol navigationTop_TipBarDelegate <NSObject>
@optional
- (void)navigationTop_TipBar:(navigationTop_TipBar *)bar didSeledtedCellForIndexPath:(NSIndexPath *)indexPath;
- (void)navigationTop_TipBar:(navigationTop_TipBar *)bar didSeledtedCellForIndexPath:(NSIndexPath *)indexPath ControllerName:(NSString *)name;
- (void)navigationTop_TipBar:(navigationTop_TipBar *)bar btnClick:(UIButton *)btn;
@end

@interface navigationTop_TipBar : UIView

@property (nonatomic , strong) NSArray *sourceDataArray;
@property (nonatomic , weak) NSIndexPath *currentChoiceIndexPath;//当前选择的cell的indexPath , 还有一个是下一次选择的indexPath
@property (nonatomic , strong) NSIndexPath *preChoiceIndexPath;//上一次cell选中的indexPath
@property (nonatomic , weak) id<navigationTop_TipBarDelegate> delegate;

@property (nonatomic , weak) UICollectionView *collectionView;
@property (nonatomic , strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic , strong) NSDictionary *carInfos;
/*
 * 栏目下方的跟踪视图
 */
@property (nonatomic , weak) UIView *followView;

/*
 * 选择栏目按钮
 */
@property (nonatomic , weak) UIButton  *selectBtn;
/*
 * 搜索车辆按钮
 */
@property (nonatomic , weak) UIButton *searchBtn;

- (NSString *)topBarCurrentTitle;
- (NSString *)getTitleWithIndex:(NSInteger)index;
- (void)updateWithDataSource:(NSArray *)sourceDataArray;
- (void)selectCell:(NSIndexPath *)indexPath;
- (void)refreshSourceData;//刷新数据源
- (KNavigationTopBarActionType)preAction;//判断是否是向前操作

@end

//
//  navigationTop_TipBar.m
//  car_video
//
//  Created by custom on 16/12/19.
//  Copyright © 2016年 self. All rights reserved.
//

#import "navigationTop_TipBar.h"
#import "recommandTop_CollectionViewCell.h"

@interface navigationTop_TipBar () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@end


@implementation navigationTop_TipBar

//刷新数据源并且刷新UI
- (void)refreshSourceData {
    
}

- (UICollectionViewFlowLayout *)flowLayout {
    if (!_flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.minimumLineSpacing = 0;
        _flowLayout.minimumInteritemSpacing = 0;
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return _flowLayout;
}

- (void)drawRect:(CGRect)rect {
    
}

- (void)updateWithDataSource:(NSArray *)sourceDataArray {
    self.sourceDataArray = sourceDataArray;
    [self.collectionView reloadData];
}

//判断是否是向前操作
- (KNavigationTopBarActionType)preAction {
    //-1 0 1
    NSInteger value = self.currentChoiceIndexPath.item-self.preChoiceIndexPath.item>0?1:(self.currentChoiceIndexPath.item-self.preChoiceIndexPath.item<0?-1:0);
    switch (value+12) {
        case KNavigationTopBarActionType_pre: { //13
            return KNavigationTopBarActionType_pre;
        }
            break;
        case KNavigationTopBarActionType_equal: { //12
            return KNavigationTopBarActionType_equal;
        }
            break;
        case KNavigationTopBarActionType_back: { //11
            return KNavigationTopBarActionType_back;
        }
            break;
        default:
            return KNavigationTopBarActionType_unknow; //14
            break;
    }
}

- (void)selectCell:(NSIndexPath *)indexPath {
    if (!indexPath)
        return ;
    
    [_collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    
    recommandTop_CollectionViewCell *last_cell = (recommandTop_CollectionViewCell *)[_collectionView cellForItemAtIndexPath:_currentChoiceIndexPath];
    last_cell.contentLabel.textColor = [UIColor grayColor];
    
    recommandTop_CollectionViewCell *cell = (recommandTop_CollectionViewCell *)[_collectionView cellForItemAtIndexPath:indexPath];
    CGPoint followViewCenter = self.followView.center;
    CGRect rect = self.followView.frame;
    
    /*
     ** 更新followView的尺寸
     */
    NSString *content = [NSString stringWithFormat:@"%@",[self.sourceDataArray objectAtIndex:indexPath.item]];
    CGFloat contentLength = [content sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]}].width;
    rect.size.width = contentLength;
    self.followView.frame = rect;
    
    followViewCenter.x = cell.center.x;
    
    self.followView.center = followViewCenter;
    cell.contentLabel.textColor = colorsWithRGB(125, 204, 233);
    
    /*
     ** 记录当前indexPath
     */
    self.preChoiceIndexPath = self.currentChoiceIndexPath;
    self.currentChoiceIndexPath = indexPath;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]){
        [self initOpacity];
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews
{
    CGSize barrierImgSize = [[UIImage imageNamed:@"bar_bg_mask_right"] size];
    //bar_btn_icon_album , bar_btn_icon_search
    CGSize albumImgSize = [[UIImage imageNamed:@"bar_btn_icon_album"] size];
    CGSize searchImgSize = [[UIImage imageNamed:@"bar_btn_icon_search"] size];
    CGFloat margin = 8;
    
    CGFloat totalLength = self.bounds.size.width - margin*3 - barrierImgSize.width - albumImgSize.width - searchImgSize.width;
    CGFloat item_W = totalLength / 4;
    CGFloat itemW = [@"推荐" sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]}].width;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, totalLength, self.bounds.size.height) collectionViewLayout:self.flowLayout];
    self.collectionView = collectionView;
    [self addSubview:collectionView];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor clearColor];
    [collectionView registerClass:[recommandTop_CollectionViewCell class] forCellWithReuseIdentifier:@"recommandTop_CollectionViewCellIdentifier"];
    collectionView.showsHorizontalScrollIndicator = NO;
    
    UIView *followView = [[UIView alloc] initWithFrame:CGRectMake((item_W-itemW)*0.5, CGRectGetMaxY(collectionView.frame)-10, itemW, 2.5)];
    followView.backgroundColor = colorsWithRGB(125, 204, 233);
    [collectionView addSubview:followView];
    self.followView = followView;
    
    /*
     ** barrierImg
     */
    UIImageView *barrierImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bar_bg_mask_right"]];
    barrierImg.frame = CGRectMake(CGRectGetMaxX(collectionView.frame), (self.bounds.size.height - barrierImgSize.height)*0.5, barrierImgSize.width, barrierImgSize.height);
    [self addSubview:barrierImg];
    
    /*
     ** 下拉
     */
    UIButton *selectBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(barrierImg.frame)+margin*2, (self.bounds.size.height - albumImgSize.height)*0.5, albumImgSize.width, albumImgSize.height)];
    self.selectBtn = selectBtn;
    [self addSubview:selectBtn];
    selectBtn.tag = 1;
    [selectBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [selectBtn setImage:[UIImage imageNamed:@"bar_btn_icon_album"] forState:UIControlStateNormal];
    
    /*
     ** 搜索
     */
    UIButton *searchBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(selectBtn.frame)+margin, (self.bounds.size.height - searchImgSize.height)*0.5, searchImgSize.width, searchImgSize.height)];
    self.searchBtn = searchBtn;
    [self addSubview:searchBtn];
    searchBtn.tag = 2;
    [searchBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [searchBtn setImage:[UIImage imageNamed:@"bar_btn_icon_search"] forState:UIControlStateNormal];
}

- (void)initOpacity {
    //默认全选
    self.sourceDataArray = [resources_tool.choiceSource copy];
    self.backgroundColor = [UIColor clearColor];
    self.currentChoiceIndexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    self.preChoiceIndexPath = [NSIndexPath indexPathForItem:0 inSection:0];
}

- (void)btnClick:(UIButton *)btn {
    if ([self.delegate respondsToSelector:@selector(navigationTop_TipBar:btnClick:)]){
        [self.delegate navigationTop_TipBar:self btnClick:btn];
    }
}

- (NSString *)topBarCurrentTitle {
    recommandTop_CollectionViewCell *cell = (recommandTop_CollectionViewCell *)[self.collectionView cellForItemAtIndexPath:self.currentChoiceIndexPath];
    return cell.contentLabel.text;
}

- (NSString *)getTitleWithIndex:(NSInteger)index {
    if (index <= self.sourceDataArray.count || index >=0) {
        return [NSString stringWithFormat:@"%@",[self.sourceDataArray objectAtIndex:index]];
    }else{
        return nil;
    }
}

#pragma mark - uicollectionViewDelegate - uicollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.sourceDataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    recommandTop_CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"recommandTop_CollectionViewCellIdentifier" forIndexPath:indexPath];
    cell.contentLabel.text = [NSString stringWithFormat:@"%@",[self.sourceDataArray objectAtIndex:indexPath.item]];
    if (indexPath.item == self.currentChoiceIndexPath.item){
        cell.contentLabel.textColor = colorsWithRGB(125, 204, 233);
    }else{
        cell.contentLabel.textColor = [UIColor grayColor];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self selectCell:indexPath];
    
    if ([self.delegate respondsToSelector:@selector(navigationTop_TipBar:didSeledtedCellForIndexPath:ControllerName:)]) {
        if ([self.delegate respondsToSelector:@selector(navigationTop_TipBar:didSeledtedCellForIndexPath:ControllerName:)]){
            NSString *name = [self.sourceDataArray objectAtIndex:indexPath.item];
            [self.delegate navigationTop_TipBar:self
                    didSeledtedCellForIndexPath:indexPath
                                 ControllerName:[self.carInfos objectForKey:name]];
        }
    }else{
        if ([self.delegate respondsToSelector:@selector(navigationTop_TipBar:didSeledtedCellForIndexPath:)]){
            [self.delegate navigationTop_TipBar:self didSeledtedCellForIndexPath:indexPath];
        }
    }
}

#pragma mark - UICollectionViewFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGSize barrierImgSize = [[UIImage imageNamed:@"bar_bg_mask_right"] size];
    //bar_btn_icon_album , bar_btn_icon_search
    CGSize albumImgSize = [[UIImage imageNamed:@"bar_btn_icon_album"] size];
    CGSize searchImgSize = [[UIImage imageNamed:@"bar_btn_icon_search"] size];
    CGFloat margin = 8;
    
    
    CGFloat totalLength = self.bounds.size.width - margin*3 - barrierImgSize.width - albumImgSize.width - searchImgSize.width;
    CGFloat itemW = totalLength / 4;
    CGFloat itemH = self.bounds.size.height;
    
    if ([[NSString stringWithFormat:@"%@",[self.sourceDataArray objectAtIndex:indexPath.item]] isEqualToString:@"原创视频"]){
        CGFloat item_W = [@"推荐" sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]}].width;
        CGFloat margin = (itemW-item_W)*0.5;
        CGFloat long_item_W = [@"原创视频" sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]}].width;
        return CGSizeMake(long_item_W+margin*2, itemH);
    }
    
    return CGSizeMake(itemW, itemH);
}

- (NSDictionary *)carInfos {
    if (!_carInfos) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"CategoryVC" ofType:@"plist"];
        _carInfos = [[NSDictionary alloc] initWithContentsOfFile:filePath];
    }
    return _carInfos;
}

@end

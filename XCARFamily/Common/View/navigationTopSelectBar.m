//
//  navigationTopSelectBar.m
//  CARFamily
//
//  Created by imac on 2017/8/29.
//  Copyright © 2017年 GuangZhouWeiControl. All rights reserved.
//

#import "navigationTopSelectBar.h"
#import "recommandTop_CollectionViewCell.h"

@interface navigationTopSelectBar ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@end

@implementation navigationTopSelectBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initOpacity];
//        [self setupSubViews];
    }
    return self;
}

- (void)initOpacity {

    self.backgroundColor = [UIColor whiteColor];
    self.currentChoiceIndexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    self.preChoiceIndexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    _vistualItems = 2;
}

- (void)drawRect:(CGRect)rect {
    
}

- (void)setVistualItems:(NSInteger)vistualItems {
    _vistualItems = vistualItems;
    [self.collectionView reloadData];
}

- (void)setupOtherActions:(void (^)())otherAction {
    if (otherAction) {
        otherAction();
    }
}

- (void)reloadData {
    [self.collectionView reloadData];
    
    //刷新下部指引视图:
    NSString *content = [NSString stringWithFormat:@"%@",[self getTheContentWithIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]]];
    CGFloat contentLength = [content sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]}].width;
    CGRect rect = self.followView.frame;
    rect.size.width = contentLength+5;
    self.followView.frame = rect;
}

#pragma mark - ---------------------UICollectionViewDelegate&UICollectionViewDataSource---------------------
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    NSInteger count = 0;
    if ([self.delegate respondsToSelector:@selector(numberOfSectionsInNavigationTopSelectBar:)]) {
        count = [self.delegate numberOfSectionsInNavigationTopSelectBar:self];
    }
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    NSInteger count = 0;
    if ([self.delegate respondsToSelector:@selector(navigationTopSelectBar:numberOfItemsInSection:)]) {
        count = [self.delegate navigationTopSelectBar:self numberOfItemsInSection:section];
    }
    return count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    recommandTop_CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"recommandTop_CollectionViewCellIdentifier" forIndexPath:indexPath];
    
    NSString *content = nil;
    if ([self.delegate respondsToSelector:@selector(navigationTopSelectBar:contentForItemAtIndexPath:)]) {
        content = [self.delegate navigationTopSelectBar:self contentForItemAtIndexPath:indexPath];
    }
    
    cell.contentLabel.text = [NSString stringWithFormat:@"%@",content];
    if (indexPath.item == self.currentChoiceIndexPath.item){
        cell.contentLabel.textColor = colorsWithRGB(125, 204, 233);
    }else{
        cell.contentLabel.textColor = [UIColor grayColor];
    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger count = 0;
    if ([self.delegate respondsToSelector:@selector(navigationTopSelectBar:numberOfItemsInSection:)]) {
        count = [self.delegate navigationTopSelectBar:self numberOfItemsInSection:indexPath.section];
    }
    
    CGFloat contentLength = collectionView.bounds.size.width / count;
    return CGSizeMake(contentLength, self.bounds.size.height);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self selectCell:indexPath];
    
    if ([self.delegate respondsToSelector:@selector(navigationTopSelectBar:didSeledtedCellForIndexPath:Name:)]) {
        NSString *name = [self getTheContentWithIndexPath:indexPath];
        [self.delegate navigationTopSelectBar:self
                  didSeledtedCellForIndexPath:indexPath
                                         Name:name];
    }else{
        if ([self.delegate respondsToSelector:@selector(navigationTopSelectBar:didSeledtedCellForIndexPath:)]){
            [self.delegate navigationTopSelectBar:self didSeledtedCellForIndexPath:indexPath];
        }
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
    NSString *content = [NSString stringWithFormat:@"%@",[self getTheContentWithIndexPath:indexPath]];
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

- (NSString *)getTheContentWithIndexPath:(NSIndexPath *)indexPath {
    NSString *content = nil;
    if ([self.delegate respondsToSelector:@selector(navigationTopSelectBar:contentForItemAtIndexPath:)]) {
        content = [self.delegate navigationTopSelectBar:self contentForItemAtIndexPath:indexPath];
    }
    return content;
}

#pragma mark - --------------------------UI---------------------------
- (void)setupSubViews {
    
    CGFloat itemW = [@"网上车展" sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]}].width;
    
    CGFloat w = itemW*_vistualItems;
    CGFloat x = (self.bounds.size.width-w)*0.5;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(x, 0, w, self.bounds.size.height) collectionViewLayout:self.flowLayout];
    self.collectionView = collectionView;
    [self addSubview:collectionView];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor clearColor];
    [collectionView registerClass:[recommandTop_CollectionViewCell class] forCellWithReuseIdentifier:@"recommandTop_CollectionViewCellIdentifier"];
    collectionView.showsHorizontalScrollIndicator = NO;
    
    CGFloat f_h = 2.5;
    UIView *followView = [[UIView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(collectionView.frame)-f_h-2, itemW*0.5, f_h)];//10是item之间的间隔
    followView.backgroundColor = colorsWithRGB(125, 204, 233);
    [collectionView addSubview:followView];
    self.followView = followView;
    
    UICollectionViewCell *cell = [self collectionView:collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
    CGPoint center = followView.center;
    center.x = cell.center.x;
    followView.center = center;
}

- (UICollectionViewFlowLayout *)flowLayout {
    if (!_flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.minimumLineSpacing = 0;
        _flowLayout.minimumInteritemSpacing = 10;
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return _flowLayout;
}

@end

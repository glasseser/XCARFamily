//
//  headScanView.m
//  car_video
//
//  Created by custom on 16/12/17.
//  Copyright © 2016年 self. All rights reserved.
//

#import "headScanView.h"
#import "headScan_CollectionViewCell.h"

#define numberOfHeadSection 10

@interface headScanView () <UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic , strong) NSArray *dataSource;
@property (nonatomic , strong) NSTimer *timer;
@property (nonatomic , assign) NSInteger currentPage;
@property (nonatomic , assign) NSInteger currentSection;

@end

@implementation headScanView

- (void)dataSourceFrom:(NSArray *)dataSource
{
    self.dataSource = dataSource;
    [self.collectionView reloadData];
    self.pageControl.numberOfPages = dataSource.count;
}

- (NSArray *)dataSources {
    return _dataSource;
}

- (void)reloadData {
    [self.collectionView reloadData];
}

- (UICollectionViewFlowLayout *)layout{
    if (!_layout){
        _layout = [[UICollectionViewFlowLayout alloc] init];
        _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _layout.minimumLineSpacing = 0;
        _layout.minimumInteritemSpacing = 0;
        _layout.itemSize = CGSizeMake(self.bounds.size.width, self.bounds.size.height);
    }
    return _layout;
}

- (void)drawRect:(CGRect)rect {
    
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]){
        
        self.currentPage = 0;
        self.currentSection = numberOfHeadSection*0.5;
        
        [self setupSubViews];
        
        [self.layer setBorderColor:[UIColor grayColor].CGColor];
        [self.layer setBorderWidth:1.0];
    }
    return self;
}


 - (void)beginScroll {
     [self endScroll];
     self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
 
 }
 
 - (void)endScroll
 {
     if (self.timer){
     [self.timer invalidate];
     self.timer = nil;
     }
 }
 

- (void)initOpacity
{
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:numberOfHeadSection * 0.5] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
}

- (void)setupSubViews
{
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height) collectionViewLayout:self.layout];
    self.collectionView = collectionView;
    [self addSubview:collectionView];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor whiteColor];
    [collectionView registerClass:[headScan_CollectionViewCell class] forCellWithReuseIdentifier:@"headScan_CollectionViewCellIdentifier"];
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.pagingEnabled = YES;
    collectionView.bounces = NO;
    
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.bounds.size.height-20, self.bounds.size.width, 20)];
    self.pageControl = pageControl;
    [self addSubview:pageControl];
    pageControl.numberOfPages = self.dataSource.count;
    pageControl.currentPage = _currentPage;
    pageControl.currentPageIndicatorTintColor = colorsWithRGB(125, 204, 233);
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
}

#pragma mark - uicollectionViewDelegate , uicollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    NSInteger count = numberOfHeadSection;
    
    if ([self.delegate respondsToSelector:@selector(numberOfSectionsInHeadScanView:)]) {
        count = [self.delegate numberOfSectionsInHeadScanView:self];
    }
    return count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    NSInteger count = self.dataSource.count;
    if ([self.delegate respondsToSelector:@selector(HeadScanView:numberOfItemsInSection:)]) {
        count = [self.delegate HeadScanView:self numberOfItemsInSection:section];
    }
    return count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectonView
                  cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    headScan_CollectionViewCell *cell = [collectonView dequeueReusableCellWithReuseIdentifier:@"headScan_CollectionViewCellIdentifier" forIndexPath:indexPath];
    
    if ([self.delegate respondsToSelector:@selector(HeadScanView:URLForItemAtIndexPath:)]) {
        [cell bindURL:[self.delegate HeadScanView:self URLForItemAtIndexPath:indexPath]];
    }
    cell.backgroundColor = [UIColor lightGrayColor];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(collectionViewImgDidSelected:focusImgModel:)]){
        id model = self.dataSource[indexPath.item];
        [self.delegate collectionViewImgDidSelected:indexPath focusImgModel:model];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self endScroll];
}

//当collectionView结束滚动的时候
- (void)collectionView:(UICollectionView *)collectionView
  didEndDisplayingCell:(UICollectionViewCell *)cell
    forItemAtIndexPath:(NSIndexPath *)indexPath {
    
    //获取可见得第一个对象
    NSIndexPath *indexP = [self.collectionView indexPathsForVisibleItems].firstObject;
    self.pageControl.currentPage = indexP.item;
}

//自动的滚到第一张的方法
- (void)nextImage {
    NSInteger numberOfItemInSection = self.dataSource.count;
    NSIndexPath *index = [self.collectionView indexPathsForVisibleItems].firstObject;
    
    NSInteger item = index.item;
    NSInteger section = index.section;
    BOOL animated = YES;
    if (section >= numberOfHeadSection-1 || section <= 0){
        section = numberOfHeadSection*0.5;
        animated = NO;
    }
    
    if (item == numberOfItemInSection - 1){
        //最后一个item，调到下一组
        //向右跳转
        if(!animated){
            [self.collectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:section] animated:animated scrollPosition:UICollectionViewScrollPositionRight];
        }
        [self.collectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:section +1] animated:YES scrollPosition:UICollectionViewScrollPositionRight];
    }else{
        if(!animated){
            [self.collectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:item inSection:section] animated:animated scrollPosition:UICollectionViewScrollPositionRight];
        }
        [self.collectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:item + 1 inSection:section] animated:YES scrollPosition:UICollectionViewScrollPositionRight];
    }
}

//结束拖拽
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self beginScroll];
}

@end

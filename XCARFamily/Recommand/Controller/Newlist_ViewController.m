//
//  Newlist_ViewController.m
//  car_video
//
//  Created by custom on 16/12/22.
//  Copyright © 2016年 self. All rights reserved.
//

#import "Newlist_ViewController.h"
#import "navigationTop_TipBar.h"

#import "SearchCar_ViewController.h"
#import "Category_ViewController.h"
#import "Recommand_ViewController.h"

#define selfViewW self.view.bounds.size.width

#import "ControllerContent_CollectionViewCell.h"

@interface Newlist_ViewController ()<navigationTop_TipBarDelegate,Category_ViewControllerDelegate,UIScrollViewDelegate>

@property (nonatomic , weak) UIButton *exitBtn;
@property (nonatomic , weak) navigationTop_TipBar *topBar;
@property (nonatomic , strong) NSMutableArray *totalSourceArray;//资源数组

@end

@implementation Newlist_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initOpacity];
    [self setupSubViews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setTopBarHide:NO];
}

- (instancetype)initWithBaseViewController:(BaseViewController *)baseVC {
    if (self = [super init]) {
        
        baseVC.indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
        baseVC.title = @"推荐";
        self.baseVC = baseVC;
    }
    return self;
}

- (void)setTopBarHide:(BOOL)hide {
    self.navigationController.navigationBar.hidden = hide;
}

- (void)initOpacity {
    self.view.backgroundColor = [UIColor whiteColor];
    _currentPage = 0;
}

#pragma mark - ----------------------navigationBar_TopTipDelegate-------------------------
- (void)navigationTop_TipBar:(navigationTop_TipBar *)bar
                    btnClick:(UIButton *)btn {
    if (btn.tag == 1){
        //下拉
        Category_ViewController *categoryVC;
        categoryVC = [[Category_ViewController alloc] init];
        categoryVC.delegate = self;
        
        [self addCustomChildViewController:categoryVC];
        
        //动画 (动画的不是控制器，而是控制器里面的子控件)
        categoryVC.view.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
        [categoryVC showActionAnimation];
        
    }else{
        //搜索
        SearchCar_ViewController *searchVC = [[SearchCar_ViewController alloc] init];
        searchVC.navigationController.navigationItem.backBarButtonItem.title = [NSString stringWithFormat:@"返回"];
        [self presentViewController:searchVC animated:YES completion:nil];
    }
}

//头部栏目选项选中事件
- (void)navigationTop_TipBar:(navigationTop_TipBar *)bar
 didSeledtedCellForIndexPath:(NSIndexPath *)indexPath
              ControllerName:(NSString *)name {
    
    _currentPage = indexPath.item;
    //控制器的全称:
    NSString *className = [NSString stringWithFormat:@"%@_ViewController",name];
    //在点击头部导航栏的时候要知道现在指示标识进行了什么操作: 1.向前移动，2.向后移动
    KNavigationTopBarActionType preAction = [_topBar preAction];
    switch (preAction) {
            //向前操作:
        case KNavigationTopBarActionType_pre: {
            [self CacheControllerScrollAction:className index:_currentPage actionType:KNavigationTopBarActionType_pre];
            break;
        }
            //向后操作:
        case KNavigationTopBarActionType_back: {
            //从缓存中获取:
            [self CacheControllerScrollAction:className index:_currentPage actionType:KNavigationTopBarActionType_back];
            break;
        }
            
        case KNavigationTopBarActionType_equal: {
            return ;
        }
            
        default:
            return ;
    }
}

//手动点击头部栏目视图触发事件:
- (void)CacheControllerScrollAction:(NSString *)class_name
                              index:(NSInteger)index
                         actionType:(KNavigationTopBarActionType)actionType {
    CGFloat vc_w = self.view.bounds.size.width;
    CGFloat vc_h = self.view.bounds.size.height-49-64;
    
    //index是当前页:
    UIViewController *vc = (UIViewController *)[self.controllerCache objectForKey:class_name];
    CGPoint point = _scrollView.contentOffset;
    if (!vc) {
        UIViewController *new_vc = [[NSClassFromString(class_name) alloc] init];
        [self addChildViewController:new_vc];
        [_scrollView addSubview:new_vc.view];
        new_vc.view.frame = CGRectMake(vc_w*index, -64, vc_w, vc_h);
        [self.controllerCache setObject:new_vc forKey:class_name];//缓存控制器
    }else{
        CGRect rect = vc.view.frame;
        rect.origin.x = vc_w*(index);
        vc.view.frame = rect;
        [_scrollView bringSubviewToFront:vc.view];
    }
    
    if (actionType == KNavigationTopBarActionType_pre) {
        point.x = vc_w*(index-1);
    }else if (actionType == KNavigationTopBarActionType_back) {
        point.x = vc_w*(index+1);
    }
    _scrollView.contentOffset = point;
    
    point = _scrollView.contentOffset;
    point.x = vc_w*index;
    [UIView animateWithDuration:0.25 animations:^{
        _scrollView.contentOffset = point;
    }];
}

#pragma mark - 添加控制器
- (void)addCustomChildViewController:(UIViewController *)vc {
    [self.navigationController addChildViewController:vc];
    UIWindow *win = [[UIApplication sharedApplication].windows firstObject];
    [win addSubview:vc.view];
}

- (void)dismissCustomChildVC:(UIViewController *)vc {
    [vc.view removeFromSuperview];
    [vc removeFromParentViewController];
}

#pragma mark - Category_ViewControllerDelegate
- (void)Category_ViewController:(Category_ViewController *)vc
      didFinishedChooseCategory:(NSDictionary *)dict {
    
    [self dismissCustomChildVC:vc];
    NSArray *choiceChannels = [dict objectForKey:@"choiceChannels"];
    NSArray *otherChannels = [dict objectForKey:@"otherChannels"];
    //刷新头部导航类型数量和类型
    [self.topBar updateWithDataSource:choiceChannels];
    
    //刷新资源工具
    resources_tool.choiceSource = nil;
    resources_tool.otherSource = nil;
    [SourceTool updateObjectAbout_Obj:[choiceChannels mutableCopy] name:@"Recommend_Choice_Info"];
    [SourceTool updateObjectAbout_Obj:[otherChannels mutableCopy] name:@"Recommend_Other_Info"];
    
    CGFloat vc_w = self.view.bounds.size.width;
    _scrollView.contentSize = CGSizeMake(vc_w*[[SourceTool shareTool]choiceSource].count, 0);
}

- (void)exitBtnClick:(UIButton *)btn {
    for (UIViewController *vc in self.childViewControllers){
        if ([vc isKindOfClass:[Category_ViewController class]]){
            [self dismissCustomChildVC:vc];
            [UIView animateWithDuration:0.25 animations:^{
                btn.alpha = 0.0;
                [btn removeFromSuperview];
            }];
            break;
        }
    }
}

#pragma mark - -------------------UIScrollViewDelegate-------------------
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat x = scrollView.contentOffset.x;
    
    //1.先判断现在是在哪个页数：   在还没有滑动到下一页之前，但是还是会看到了下一页的界面，要显示出来
    //获取当前锁处的位置
    NSInteger index = (NSInteger)((x+selfViewW*0.5) / selfViewW);//当前页数
    if (index == _currentPage)
        return ;
    NSLog(@"停止拖拽后停留在了%zd页",index);
    _currentPage = index;
    [_topBar selectCell:[NSIndexPath indexPathForItem:index inSection:0]];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    //获取当前锁处的位置
    CGFloat x = scrollView.contentOffset.x;
    NSInteger index = (NSInteger)(x / selfViewW);//当前页数
    NSLog(@"当期所在的页数是:%zd",index);
    _currentPage = index;
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset NS_AVAILABLE_IOS(5_0) {
//    NSLog(@"想着开始停止拖拽");
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
//    NSLog(@"已经结束拖拽，");
    
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
//    NSLog(@"正想着开始减速");
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSLog(@"已经结束---->");
    
    //加载控制器
    NSString *controllerName = [_topBar topBarCurrentTitle];
    NSString *className = [[NSString alloc] initWithFormat:@"%@_ViewController",[SourceTool getControllerClassNameWith:controllerName]];
    for (NSString *sub_vc_name in self.controllerCache.allKeys) {
        
        if ([sub_vc_name isEqualToString:className]) {
            return ;
        }
    }
    CGFloat vc_w = self.view.bounds.size.width;
    CGFloat vc_h = self.view.bounds.size.height-49-64;
    UIViewController *vc = (UIViewController *)[[NSClassFromString(className) alloc] init];
    [self addChildViewController:vc];
    [_scrollView addSubview:vc.view];
    vc.view.frame = CGRectMake(vc_w*_currentPage, -64, vc_w, vc_h);
    [self.controllerCache setObject:vc forKey:className];//缓存控制器
}

#pragma mark - --------------------懒加载--------------------
- (NSMutableArray *)totalSourceArray {
    if (!_totalSourceArray) {
        NSInteger choiceSourceCount = resources_tool.choiceSource.count;
        NSInteger otherSourceCount = resources_tool.otherSource.count;
        _totalSourceArray = [[NSMutableArray alloc] initWithCapacity:choiceSourceCount + otherSourceCount];
        
        [_totalSourceArray addObjectsFromArray:[resources_tool.choiceSource copy]];
        [_totalSourceArray addObjectsFromArray:[resources_tool.otherSource copy]];
    }
    return _totalSourceArray;
}

#pragma mark - ---------------------UI----------------------
- (void)setupSubViews {
    //navigationBar
    navigationTop_TipBar *topBar = [[navigationTop_TipBar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
    [self.navigationController.navigationBar addSubview:topBar];
    topBar.delegate = self;
    self.topBar = topBar;
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    
    CGFloat vc_w = self.view.bounds.size.width;
    CGFloat vc_h = self.view.bounds.size.height-49-64;
    
    /*
     UIScrollView
     */
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, vc_w, vc_h)];
    [self.view addSubview:_scrollView];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.delegate = self;
    _scrollView.bouncesZoom = NO;
    _scrollView.bounces = YES;
    _scrollView.directionalLockEnabled = YES;
    _scrollView.alwaysBounceVertical = NO;
    _scrollView.pagingEnabled = YES;
    
    _scrollView.contentSize = CGSizeMake(vc_w*[[SourceTool shareTool]choiceSource].count, 0);
    _scrollView.contentOffset = CGPointMake(0, 0);
    _scrollView.backgroundColor = [UIColor whiteColor];
    
    Recommand_ViewController *vc = [[Recommand_ViewController alloc] init];
    [self addChildViewController:vc];
    [_scrollView addSubview:vc.view];
    vc.view.frame = CGRectMake(0, -64, vc_w, vc_h);
    //缓存数据库:
    [self.controllerCache setObject:vc forKey:@"Recommand_ViewController"];
}

- (NSMutableDictionary *)controllerCache {
    if (!_controllerCache) {
        _controllerCache = [NSMutableDictionary dictionary];
    }
    return _controllerCache;
}

- (void)dealloc {
    
}




@end

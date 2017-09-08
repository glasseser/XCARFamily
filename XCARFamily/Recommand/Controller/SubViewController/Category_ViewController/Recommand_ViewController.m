//
//  Recommand_ViewController.m
//  car_video
//
//  Created by custom on 16/12/9.
//  Copyright © 2016年 self. All rights reserved.
//

#import "Recommand_ViewController.h"
#import "SearchCar_ViewController.h"
#import "Category_ViewController.h"

#import "recommand_TableViewCell.h"
#import "headScanView.h"
#import "navigationTop_TipBar.h"

#import "recommandMsg_Model.h"
#import "focusImg_Model.h"

#import "LoadingView_TypeOne.h"

@interface Recommand_ViewController ()<UITableViewDelegate,UITableViewDataSource,headScanViewDelegate>

@property (nonatomic , weak) UITableView *tableView;
@property (nonatomic , strong) NSMutableArray *sourceArray;
@property (nonatomic , weak) headScanView *scanHeadView;

@property (nonatomic , weak) MBProgressHUD *hud;
@property (nonatomic , weak) UIButton *exitBtn;

@property (nonatomic , assign) BOOL isLoading;
@property (nonatomic , strong) NSArray *linkURLs;//仅仅测试使用

@end

@implementation Recommand_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initOpacity];
    [self setupSubViews];
    
    [self setupRefresh];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)loadData:(void (^)(NSDictionary *dict))otherAction {
    __weak typeof(self)weakSelf = self;
    
    if (_isLoading) {
        return ;
    }
    
    _isLoading = YES;
    
    [Tool network:[NSString stringWithFormat:@"%@%@",networkUrl_Foundation,networkUrl_news]
    finishedBlock:^(NSDictionary *dict) {
        
        if (otherAction){
            otherAction(nil);
        }
        
        if (![dict objectForKey:@"errorMsg"]){
            weakSelf.tipNullTxt.hidden = YES;
            
            NSArray *newslists = [recommandMsg_Model dataSourceWithDict:dict key:@"newslist"];
            NSArray *focusimgs = [focusImg_Model dataSourceWithDict:dict key:@"focusimg"];
            weakSelf.sourceArray = [@[focusimgs,newslists] mutableCopy];
            [weakSelf.scanHeadView dataSourceFrom:focusimgs];
            [weakSelf.tableView reloadData];
            
            NSInteger count = [[weakSelf.sourceArray lastObject] count];
            weakSelf.scanHeadView.hidden = !count;
            if (count){
                [weakSelf.scanHeadView initOpacity];
                [weakSelf.scanHeadView beginScroll];
            }
        }else{
            weakSelf.hud.labelText = @"超时";
            weakSelf.tipNullTxt.hidden = NO;
        }
        weakSelf.isLoading = NO;
    }];
}

- (void)setupSubViews {
    headScanView *scanHeadView = [[headScanView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.width*0.55)];
    //[self.view addSubview:scanHeadView];
    scanHeadView.delegate = self;
    self.scanHeadView = scanHeadView;
    //CGRectGetMaxY(scanHeadView.frame)
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView = tableView;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:tableView];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = [NSString stringWithFormat:@"没有数据,请重试"];
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [UIColor lightGrayColor];
    [self.view addSubview:label];
    label.hidden = YES;
    self.tipNullTxt = label;
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.left.offset(0);
        make.right.offset(0);
        make.bottom.offset(0);
    }];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.centerY.offset(0);
    }];
    
    tableView.tableHeaderView = scanHeadView;
    
    NSInteger count = [[self.sourceArray lastObject] count];
    scanHeadView.hidden = !count;
    
//    LoadingView_TypeOne *load_view = [[LoadingView_TypeOne alloc] initWithView:self.view];
//    [self.view addSubview:load_view];
//    [load_view show:YES];
}

#pragma mark - uitableViewDelegate - tableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count = [[self.sourceArray lastObject] count];
    return count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    recommand_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"recommand_TableViewCell_typenormal"];
    if (!cell){
        cell = [[recommand_TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"recommand_TableViewCell_typenormal"];
    }
    
    NSArray *sourceArray = [self.sourceArray lastObject];
    recommandMsg_Model *model = sourceArray[indexPath.item];
    [cell bindModel:model];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    UIViewController *parant_vc = [self parentViewController];
    for (UIView *sub_view in parant_vc.navigationController.navigationBar.subviews) {
        if ([sub_view isKindOfClass:[navigationTop_TipBar class]]) {
            sub_view.hidden = YES;
            break;
        }
    }
    
    int count = (int)self.linkURLs.count;
    int ran_index = (int)arc4random_uniform(count);
    NSString *url_string = [_linkURLs objectAtIndex:ran_index];
    
    NSArray *sourceArray = [self.sourceArray lastObject];
    recommandMsg_Model *model = sourceArray[indexPath.item];
    NSString *title = model.title;
    
    MessageDetailWeb_ViewController *vc = [[MessageDetailWeb_ViewController alloc] initWithTitle:title];
    [parant_vc.navigationController pushViewController:vc animated:YES];
    [vc loadMsgWithURL:url_string];
}

#pragma mark - headScanViewDelegate - 图片轮播
- (void)collectionViewImgDidSelected:(NSIndexPath *)indexPath
                       focusImgModel:(id)model {
    
    NSLog(@"图片滚动-选择的_model是：%@",model);
    NSLog(@"indexPath = %@",indexPath);
}

- (NSString *)HeadScanView:(headScanView *)scanView
     URLForItemAtIndexPath:(NSIndexPath *)indexPath {
    focusImg_Model *model = [[scanView dataSources] objectAtIndex:indexPath.item];
    return model.imgurl;
}

#pragma mark - 集成下拉功能
/**
 *  集成下拉刷新
 */
- (void)setupRefresh {
    //添加刷新控件
    UIRefreshControl *control = [[UIRefreshControl alloc]init];
    [control addTarget:self action:@selector(refreshStateChange:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:control];
    [control beginRefreshing];
    [self refreshStateChange:control];
}

- (void)refreshStateChange:(UIRefreshControl *)control {
    __weak typeof(control)weakControl = control;
    [self loadData:^(NSDictionary *dict) {
        [weakControl endRefreshing];
    }];
}

#pragma mark - 基本设置：
- (void)initOpacity {
    _isLoading = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    _currentChoice_ViewController = 0;//默认是选择第一个  e.g: “推荐”
}

- (void)hudShow {
    [self hudHide];
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
    self.hud = hud;
    [self.view addSubview:hud];
    hud.removeFromSuperViewOnHide = YES;
    [self.hud show:YES];
}

- (void)hudHide {
    if (self.hud) {
        [self.hud hide:YES];
        [self.hud removeFromSuperview];
        self.hud = nil;
    }
}

- (NSArray *)linkURLs {
    if (!_linkURLs) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"WebLinkList" ofType:@"plist"];//WebLinkList  NewsLinkListst
        _linkURLs = [[NSArray alloc] initWithContentsOfFile:filePath];
    }
    return _linkURLs;
}

#pragma mark - dealloc
- (void)dealloc {
    
    NSLog(@"推荐控制器已经销毁!!");
}

@end

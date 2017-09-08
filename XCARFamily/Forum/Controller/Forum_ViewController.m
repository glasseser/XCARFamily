//
//  Forum_ViewController.m
//  car_video
//
//  Created by custom on 16/12/9.
//  Copyright © 2016年 self. All rights reserved.
//

#import "commonPCH.pch"

#import "navigationTop_TipBar.h"
#import "Forum_ViewController.h"
#import "Forum_TableViewCell.h"
#import "ForumsHeadModel.h"
#import "headScanView.h"
#import "ForumsModel.h"
#import "Masonry.h"
#import "Tool.h"

@class focusImg_Model;

@interface Forum_ViewController ()<UITableViewDelegate,UITableViewDataSource,headScanViewDelegate>
@property (nonatomic , weak) UITableView *tableView;
@property (nonatomic , strong) NSMutableArray *sourceArray;
@property (nonatomic , weak) headScanView *scanHeadView;
@property (nonatomic , assign) BOOL isLoading;

@end

@implementation Forum_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initOpacity];
    [self setupSubViews];
    
    [self setupRefresh];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)loadData:(void (^)(NSDictionary *dict))otherAction {
    __weak typeof(self)weakSelf = self;
    
    if (_isLoading) {
        return ;
    }
    
    _isLoading = YES;

    [Tool Post:@"http://mi.xcar.com.cn/interface/xcarapp/getSelectedPostList.php"
    Parameters:@{@"limit":@20,@"offset":@0,@"type":@1,@"ver":@6.2}
       Setting:nil
       Success:^(NSURLSessionDataTask *task, id responseObject) {
        
           if (![responseObject isKindOfClass:[NSError class]] || ![responseObject isKindOfClass:[NSNull class]]) {
               if ([responseObject isKindOfClass:[NSData class]]) {
                   NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                   NSLog(@"dict = %@",dict);
               }else if([responseObject isKindOfClass:[NSDictionary class]]){

                   [weakSelf.sourceArray removeAllObjects];
                   NSDictionary *dict = (NSDictionary *)responseObject;
                   NSArray *focusPosts = [dict objectForKey:@"focusPost"];
                   NSArray *postLists = [dict objectForKey:@"postList"];
                   NSMutableArray *headdatasources = [NSMutableArray arrayWithCapacity:focusPosts.count];
                   NSMutableArray *msgLists = [NSMutableArray arrayWithCapacity:postLists.count];
                   
                   for (NSDictionary *focusPost in focusPosts) {
                       ForumsHeadModel *model = [ForumsHeadModel ModelWithDict:focusPost];
                       [headdatasources addObject:model];
                   }
                   
                   for (NSDictionary *post in postLists) {
                       ForumsModel *model = [ForumsModel ModelWithDict:post];
                       [msgLists addObject:model];
                   }
                   [weakSelf.sourceArray addObjectsFromArray:[msgLists copy]];
                   [weakSelf.scanHeadView dataSourceFrom:[headdatasources copy]];
                   [weakSelf.tableView reloadData];
                   
                   weakSelf.scanHeadView.hidden = ![[headdatasources copy] count];
                   if ([[headdatasources copy] count]){
                       [weakSelf.scanHeadView initOpacity];
                       [weakSelf.scanHeadView beginScroll];
                   }
                   
               }else{
                   NSLog(@"responseObject = %@",responseObject);
               }
           }else{
               NSLog(@"获取失败");
           }
           
           if (otherAction) {
               otherAction(nil);
           }
           weakSelf.isLoading = NO;
           
    } Fail:^(NSURLSessionDataTask *task, NSError *error) {
        if (otherAction) {
            otherAction(nil);
        }
        NSLog(@"error = %@",error);
        weakSelf.isLoading = NO;
    }];

}

- (void)initOpacity {
    self.view.backgroundColor = [UIColor whiteColor];
//    self.title = @"论坛";
}

#pragma mark - headScanViewDelegate - 图片轮播
- (void)collectionViewImgDidSelected:(NSIndexPath *)indexPath
                       focusImgModel:(id)model {
    
    NSLog(@"图片滚动-选择的_model是：%@",model);
    NSLog(@"indexPath = %@",indexPath);
    [self loadWebWith:[[_scanHeadView dataSources] objectAtIndex:indexPath.row]];
}

- (NSString *)HeadScanView:(headScanView *)scanView
     URLForItemAtIndexPath:(NSIndexPath *)indexPath {
    ForumsHeadModel *model = [[scanView dataSources] objectAtIndex:indexPath.item];
    return model.focusImage;
}

#pragma mark - ---------------------- UITableViewDelegate&UITableViewDataSource-----------------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.sourceArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Forum_TableViewCell *cell = (Forum_TableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"tableviewcellIndentifier"];
    if (!cell) {
        cell = [[Forum_TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"tableviewcellIndentifier"];
    }
    [cell bindModel:[self.sourceArray objectAtIndex:indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    [self loadWebWith:[self.sourceArray objectAtIndex:indexPath.row]];
}

#pragma mark - 页面跳转
- (void)loadWebWith:(NSObject *)model {
    UIViewController *parant_vc = self;
    for (UIView *sub_view in parant_vc.navigationController.navigationBar.subviews) {
        if ([sub_view isKindOfClass:[navigationTop_TipBar class]]) {
            sub_view.hidden = YES;
            break;
        }
    }
    
    NSString *url=@"";
    NSString *title = @"";
    if ([model isKindOfClass:[ForumsModel class]]) {
        url = ((ForumsModel *)model).postLink;
        title = ((ForumsModel *)model).postTitle;
    }else if ([model isKindOfClass:[ForumsHeadModel class]]){
        url = ((ForumsHeadModel *)model).focusLink;
        title = ((ForumsHeadModel *)model).focusTitle;
    }
    
    MessageDetailWeb_ViewController *vc = [[MessageDetailWeb_ViewController alloc] initWithTitle:title];
    
    [parant_vc.navigationController pushViewController:vc animated:YES];
    [vc loadMsgWithURL:url];
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

- (void)setupSubViews {
    headScanView *scanHeadView = [[headScanView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.width*0.55)];
    scanHeadView.delegate = self;
    self.scanHeadView = scanHeadView;

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
}

- (NSMutableArray *)sourceArray {
    if (!_sourceArray) {
        _sourceArray = [NSMutableArray array];
    }
    return _sourceArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end

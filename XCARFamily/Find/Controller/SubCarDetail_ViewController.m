//
//  SubCarDetail_ViewController.m
//  CARFamily
//
//  Created by imac on 2017/8/29.
//  Copyright © 2017年 GuangZhouWeiControl. All rights reserved.
//

#import "SubCarDetail_ViewController.h"
#import "SubCarDetail_Engine_Model.h"
#import "SubCarDetail_TableViewCell.h"
#import "SubCarDetail_Cars_Model.h"
#import "SubCarDetailModel.h"

@interface SubCarDetail_ViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) navigationTopSelectBar *topBar;
@property (nonatomic , weak) LoadingView_TypeOne *loadingView;

@end

@implementation SubCarDetail_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubViews];
    [self initCapacity];
    
    [self loadData];
}

- (void)initCapacity {
    self.view.backgroundColor = [UIColor whiteColor];
}


- (void)loadData {
    __weak typeof(self)wself = self;
    LoadingView_TypeOne *loadingView = [[LoadingView_TypeOne alloc] initWithView:self.view];
    [self.view addSubview:loadingView];
    [loadingView show:YES];
    _loadingView = loadingView;
    [Tool Post:_urlString
    Parameters:nil
       Setting:nil
       Success:^(NSURLSessionDataTask *task, id responseObject) {
           NSLog(@"responseObject = %@",responseObject);
           [loadingView hide:YES];
           if (![responseObject isKindOfClass:[NSNull class]] || ![responseObject isKindOfClass:[NSError class]]) {
               NSDictionary *dict = (NSDictionary *)responseObject;
               SubCarDetailModel *model = [SubCarDetailModel ModelWithDict:dict];
               wself.model = model;
               wself.DataSources = [NSMutableArray arrayWithArray:model.saleSubSeries];
               if (wself.DataSources.count && wself.DataSources) {
                   wself.tableView.hidden = NO;
                   [wself.tableView reloadData];
               }
           }
       } Fail:^(NSURLSessionDataTask *task, NSError *error) {
           NSLog(@"error = %@",error);
           [loadingView hide:YES];
       }];
}

#pragma mark - --------------------UI------------------

- (void)setupSubViews {
    [self setupTopBar];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-64-49) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.hidden = YES;
}

- (void)setupTopBar {
    __weak typeof(self)wself = self;
    navigationTopSelectBar *topBar = [[navigationTopSelectBar alloc] initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, 44)];
    _topBar = topBar;
    [self.view addSubview:topBar];
    
    [topBar setupOtherActions:^() {
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = [UIColor grayColor];
        line.alpha = 0.6;
        [topBar addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(0);
            make.bottom.offset(0);
            make.right.offset(0);
            make.height.equalTo(@0.8);
        }];
        
        UIButton *btn = [[UIButton alloc] init];
        [btn setImage:[UIImage imageNamed:@"顶部左上角返回按钮"] forState:UIControlStateNormal];
        [topBar addSubview:btn];
        [btn addTarget:wself
                action:@selector(backBtnClick:)
      forControlEvents:UIControlEventTouchUpInside];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(10);
            make.centerY.offset(0);
        }];
    }];
}

- (void)backBtnClick:(UIButton *)btn {
    [_loadingView hide:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - ------------------------UITableViewDelegate&UITableViewDataSource--------------------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger count = self.DataSources.count;
    return count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    SubCarDetail_Engine_Model *model = [self.DataSources objectAtIndex:section];
    NSInteger count = model.cars.count;
    return count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UITableViewHeaderFooterView *headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"UITableViewHeaderFooterView__CarBrands_HeadView"];
    NSInteger viewType = 999;
    if (!headView) {
        headView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"UITableViewHeaderFooterView__CarBrands_HeadView"];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = [UIColor darkGrayColor];
        label.backgroundColor = colorsWithRGB(221,221,221);
        label.tag = viewType;
        [headView.contentView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(0);
            make.left.offset(0);
            make.bottom.offset(0);
            make.right.offset(0);
        }];
    }
    
    UILabel *label = [headView viewWithTag:viewType];
    SubCarDetail_Engine_Model *model = [self.DataSources objectAtIndex:section];
    label.text = [NSString stringWithFormat:@"  %@",model.engine];
    return headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SubCarDetail_TableViewCell *cell = (SubCarDetail_TableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"SubCarDetail_TableViewCell_Identifier"];
    if (!cell) {
        cell = [[SubCarDetail_TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SubCarDetail_TableViewCell_Identifier"];
    }
    SubCarDetail_Engine_Model *model = [self.DataSources objectAtIndex:indexPath.section];
    NSArray *array = model.cars;
    SubCarDetail_Cars_Model *detailModel = [array objectAtIndex:indexPath.row];
    
    [cell bindModel:detailModel];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    SubCarDetail_Engine_Model *model = [self.DataSources objectAtIndex:indexPath.section];
    NSArray *array = model.cars;
    SubCarDetail_Cars_Model *detailModel = [array objectAtIndex:indexPath.row];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)dealloc {
    NSLog(@"SubCarDetail_ViewController ----> 销毁！！");
}


@end

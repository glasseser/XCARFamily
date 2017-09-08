//
//  SubCar_ViewController.m
//  car_video
//
//  Created by imac on 2017/8/28.
//  Copyright © 2017年 self. All rights reserved.
//

#import "SubCarDetail_ViewController.h"
#import "CarBrand_TableViewCell.h"
#import "SubCar_ViewController.h"
#import "CarBrandDetailModel.h"
#import "SubCarBrandsModel.h"
#import "CarBrandModel.h"

@interface SubCar_ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) CarBrandModel *brandmodel;
@property (nonatomic , strong) navigationTopSelectBar *topBar;
@property (nonatomic , weak) LoadingView_TypeOne *loadingView;

@end

@implementation SubCar_ViewController

- (instancetype)initWithModel:(CarBrandModel *)model {
    if (self = [super init]) {
        _brandmodel = model;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupSubViews];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (!_DataSources) {
        [self loadData];
    }
}

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
    topBar.delegate = self;
    [self.view addSubview:topBar];
    dispatch_async(dispatch_get_main_queue(), ^{
        [topBar setupSubViews];
    });
    
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

- (void)loadData {
    __weak typeof(self)wself = self;
    LoadingView_TypeOne *loadingView = [[LoadingView_TypeOne alloc] initWithView:self.view];
    _loadingView = loadingView;
    [self.view addSubview:loadingView];
    [loadingView show:YES];
    [Tool Post:@"http://mi.xcar.com.cn/interface/xcarapp/getSeriesByBrandId.php"
    Parameters:@{@"brandId":@(_brandmodel.id)}
       Setting:nil
       Success:^(NSURLSessionDataTask *task, id responseObject) {
           NSLog(@"responseObject = %@",responseObject);
           [loadingView hide:YES];
           if (![responseObject isKindOfClass:[NSNull class]] || ![responseObject isKindOfClass:[NSError class]]) {
               NSMutableArray *mul = [NSMutableArray array];
               NSDictionary *dict = (NSDictionary *)responseObject;
               NSArray *array = [dict objectForKey:@"subBrands"];
               for (NSDictionary *dic in array) {
                   NSLog(@"dic = %@",dic);
                   SubCarBrandsModel *model = [SubCarBrandsModel ModelWithDict:dic];
                   [mul addObject:model];
               }
               wself.DataSources = [mul mutableCopy];
               if (wself.DataSources.count) {
                   wself.tableView.hidden = NO;
                   [wself.tableView reloadData];
               }
           }
           
    } Fail:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error = %@",error);
        [loadingView hide:YES];
    }];
}

#pragma mark - -----------------------navigationTopSelectBarDelegate------------------------------
- (void)navigationTopSelectBar:(navigationTopSelectBar *)bar
   didSeledtedCellForIndexPath:(NSIndexPath *)indexPath
                          Name:(NSString *)name {
    
    NSLog(@"name = %@",name);
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInNavigationTopSelectBar:(navigationTopSelectBar *)topBar {
    return 1;
}

- (NSInteger)navigationTopSelectBar:(navigationTopSelectBar *)topBar
             numberOfItemsInSection:(NSInteger)section {
    return 2;
}

- (NSString *)navigationTopSelectBar:(navigationTopSelectBar *)topBar contentForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item == 0)
        return @"在售";
    return @"停售";
}

#pragma mark - ------------------------UITableViewDelegate&UITableViewDataSource--------------------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.DataSources.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    SubCarBrandsModel *model = [self.DataSources objectAtIndex:section];
    /*
     @"sales",@"unSales"
     */
    NSArray *sales = [[model.series firstObject] objectForKey:@"sales"];
    NSArray *unSales = [[model.series firstObject] objectForKey:@"unSales"];
    
    if (_topBar.currentChoiceIndexPath.item == 0) {
        return [sales count];
    }
    return [unSales count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 86;
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
    SubCarBrandsModel *model = [self.DataSources objectAtIndex:section];
    label.text = [NSString stringWithFormat:@"  %@",model.subBrandName];
    return headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CarBrand_TableViewCell *cell = (CarBrand_TableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"CarBrand_TableViewCell_Identifier"];
    if (!cell) {
        cell = [[CarBrand_TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CarBrand_TableViewCell_Identifier"];
    }
    
    SubCarBrandsModel *model = [self.DataSources objectAtIndex:indexPath.section];
    /*
     @"sales",@"unSales"
     */
    NSArray *sales = [[model.series firstObject] objectForKey:@"sales"];
    NSArray *unSales = [[model.series firstObject] objectForKey:@"unSales"];
    CarBrandDetailModel *detail_model;
    
    if (_topBar.currentChoiceIndexPath.item == 0) {
        detail_model  = [sales objectAtIndex:indexPath.row];
    }else{
        detail_model  = [unSales objectAtIndex:indexPath.row];
    }
    [cell bindModel:detail_model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    SubCarBrandsModel *model = [self.DataSources objectAtIndex:indexPath.section];
    /*
     @"sales",@"unSales"
     */
    NSArray *sales = [[model.series firstObject] objectForKey:@"sales"];
    NSArray *unSales = [[model.series firstObject] objectForKey:@"unSales"];
    CarBrandDetailModel *detail_model;
    
    if (_topBar.currentChoiceIndexPath.item == 0) {
        detail_model  = [sales objectAtIndex:indexPath.row];
    }else{
        detail_model  = [unSales objectAtIndex:indexPath.row];
    }
    
    NSString *urlString = [NSString stringWithFormat:@"%@?seriesId=%@",@"http://mi.xcar.com.cn/interface/xcarapp/getSeriesInfoNew.php",@(detail_model.seriesId)];
    SubCarDetail_ViewController *vc = [[SubCarDetail_ViewController alloc] init];
    vc.urlString = urlString;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)dealloc {
    NSLog(@"销毁！！！！！");
}

@end

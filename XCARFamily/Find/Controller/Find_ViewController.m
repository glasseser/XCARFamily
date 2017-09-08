//
//  Find_ViewController.m
//  car_video
//
//  Created by custom on 16/12/9.
//  Copyright © 2016年 self. All rights reserved.
//

#import "CarBrandInfo_TableViewCell.h"
#import "SubCar_ViewController.h"
#import "Find_ViewController.h"
#import "CarBrandModel.h"
#import "LettersModel.h"
#import "Masonry.h"
#import "Tool.h"

#define randomColor [[UIColor alloc] initWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0]
#define colorsWithRGB(r,g,b) [[UIColor alloc] initWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]

@interface Find_ViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation Find_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupSubViews];
    [self initDataSources];
    
    [self setupRefresh];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

#pragma mark - --------------------初始化-------------------
- (void)initDataSources {
    
}

#pragma mark - ----------------------集成下拉功能------------------------
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

- (void)loadData:(void (^)(NSDictionary *dict))otherAction {
    __weak typeof(self)weakSelf = self;
    
    [Tool Post:@"http://mi.xcar.com.cn/interface/xcarapp/getBrands.php"
    Parameters:nil
       Setting:nil
       Success:^(NSURLSessionDataTask *task, id responseObject) {
           
           if (![responseObject isKindOfClass:[NSError class]] || ![responseObject isKindOfClass:[NSNull class]]) {
               if ([responseObject isKindOfClass:[NSData class]]) {
                   NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                   NSLog(@"dict = %@",dict);
               }else if([responseObject isKindOfClass:[NSDictionary class]]){
                   
                   NSDictionary *respons = (NSDictionary *)responseObject;
                   NSArray *array = [respons objectForKey:@"letters"];
                   NSMutableArray *mul_array = [NSMutableArray arrayWithCapacity:array.count];
                   for (NSDictionary *dic in array) {
                       LettersModel *model = [LettersModel ModelWithDict:dic];
                       [mul_array addObject:model];
                   }
                   weakSelf.datasources = [mul_array copy];
                   if (weakSelf.datasources.count) {
                       [weakSelf.tableView reloadData];
                       weakSelf.tableView.hidden = NO;
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
           
       } Fail:^(NSURLSessionDataTask *task, NSError *error) {
           if (otherAction) {
               otherAction(nil);
           }
           NSLog(@"error = %@",error);
       }];
}

#pragma mark - ---------------------UITbleViewDelegate&&UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.datasources.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    LettersModel *model = [self.datasources objectAtIndex:section];
    return model.brands.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 56;
}

// return list of section titles to display in section index view (e.g. "ABCD...Z#")
- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return self.titles;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    
    
    NSLog(@"title = %@,index = %zd",title,index);
    
    [tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
    return -1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CarBrandInfo_TableViewCell *cell = (CarBrandInfo_TableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"CarBrandInfo_TableViewCell_Identifier"];
    if (!cell) {
        cell = [[CarBrandInfo_TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CarBrandInfo_TableViewCell_Identifier"];
    }
    LettersModel *letter_model = [self.datasources objectAtIndex:indexPath.section];
    CarBrandModel *brand = [letter_model.brands objectAtIndex:indexPath.row];
    [cell bindModel:brand];
    return cell;
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
        label.font = [UIFont systemFontOfSize:18];
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
    LettersModel *model = [self.datasources objectAtIndex:section];
    label.text = [NSString stringWithFormat:@"  %@",[model.letter uppercaseString]];
    return headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    LettersModel *letter_model = [self.datasources objectAtIndex:indexPath.section];
    CarBrandModel *model = [letter_model.brands objectAtIndex:indexPath.row];
    
    SubCar_ViewController *sub_vc = [[SubCar_ViewController alloc] initWithModel:model];
    [self.navigationController pushViewController:sub_vc animated:YES];
}

#pragma mark - --------------------UI----------------------
- (void)setupSubViews {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView = tableView;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:tableView];
    tableView.hidden = YES;
    
    /*
     @property (nonatomic) NSInteger sectionIndexMinimumDisplayRowCount;                                                      // show special section index list on right when row count reaches this value. default is 0
     @property (nonatomic, strong, nullable) UIColor *sectionIndexColor NS_AVAILABLE_IOS(6_0) UI_APPEARANCE_SELECTOR;                   // color used for text of the section index
     @property (nonatomic, strong, nullable) UIColor *sectionIndexBackgroundColor NS_AVAILABLE_IOS(7_0) UI_APPEARANCE_SELECTOR;         // the background color of the section index while not being touched
     @property (nonatomic, strong, nullable) UIColor *sectionIndexTrackingBackgroundColor NS_AVAILABLE_IOS(6_0) UI_APPEARANCE_SELECTOR; // the background color of the section index while it is being touched
     */
//    tableView.sectionIndexMinimumDisplayRowCount = 3;
    tableView.sectionIndexColor = [UIColor grayColor];
    tableView.sectionIndexBackgroundColor = [UIColor clearColor];
//    tableView.sectionIndexTrackingBackgroundColor = [UIColor lightGrayColor];
    
    UIView *head_view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 5)];
    tableView.tableHeaderView = head_view;
    
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
}

- (NSArray *)titles {
    if (!_titles) {
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:self.datasources.count];
        if (self.datasources.count) {
            for (LettersModel *model in self.datasources) {
                [array addObject:[model.letter uppercaseString]];
            }
            _titles = [array copy];
        }
    }
    return _titles;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end

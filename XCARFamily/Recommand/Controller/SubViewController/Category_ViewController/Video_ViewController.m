//
//  Video_ViewController.m
//  car_video
//
//  Created by custom on 16/12/23.
//  Copyright © 2016年 self. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import <MediaPlayer/MediaPlayer.h>

#import "VideoInfo_TableViewCell.h"
#import "Video_ViewController.h"
#import "VideoInfoModel.h"

@interface Video_ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) navigationTopSelectBar *topBar;
@property (nonatomic , strong) NSArray *NewsSource;
@property (nonatomic , weak) UITableView *tableView;
@property (nonatomic , strong) NSMutableArray *sourceArray;

@property (nonatomic , strong) AVPlayerItem *playerItem;
@property (nonatomic , strong) AVPlayer *player;
@property (nonatomic , strong) AVPlayerLayer *playerLayer;

//@property (nonatomic , strong) MPMoviePlayerController *playerC;
//@property (nonatomic , strong) MPMoviePlayerViewController *playerVC;

@end

@implementation Video_ViewController

- (void)viewDidLoad {
    /*
     0.3 新闻的类型 1为最新新闻（大杂烩） 2（国内外新车） 3（评测） 4（导购） 5（行情）
     http://mi.xcar.com.cn/interface/xcarapp/getVideo.php?type=4
     */
    [super viewDidLoad];
    
    
    self.VCNameLabel.text = @"视频";
    [self setupSubViews];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self setupRefresh];
}

- (void)setupSubViews {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView = tableView;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:tableView];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
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


#pragma mark - uitableViewDelegate - tableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count = [self.sourceArray count];
    return count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat w = self.view.bounds.size.width;
    CGFloat h = w/200 * 112;
    return h+34; //200x112
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    VideoInfo_TableViewCell *cell = (VideoInfo_TableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"VideoInfo_TableViewCell_Identifier"];
    if (!cell) {
        cell = [[VideoInfo_TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"VideoInfo_TableViewCell_Identifier"];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    
    VideoInfoModel *model = [self.sourceArray objectAtIndex:indexPath.row];
    [cell bindModel:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    VideoInfoModel *model = [self.sourceArray objectAtIndex:indexPath.row];
    NSString *src = model.src;
//    _playerVC = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL URLWithString:src]];
////    [self addChildViewController:_player];
//    [self presentMoviePlayerViewControllerAnimated:_playerVC];
    
//    [self setupPlayer:[NSURL URLWithString:src]];
    
    VideoInfo_TableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.playView.hidden = YES;
    cell.play_bg.hidden = YES;
    
    NSURL *url = [NSURL URLWithString:src];
    _playerItem = [[AVPlayerItem alloc] initWithURL:url];
    _player = [AVPlayer playerWithPlayerItem:_playerItem];
    _playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
    _playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    [cell.iconView.layer addSublayer:_playerLayer];
    _playerLayer.frame = cell.iconView.layer.bounds;
    
    [_player play];
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

- (void)loadData:(void (^)(NSDictionary *dict))otherAction {
    __weak typeof(self)weakSelf = self;
    
    [Tool Post:@"http://mi.xcar.com.cn/interface/xcarapp/getVideo.php"
    Parameters:@{@"type":@4}
       Setting:nil
       Success:^(NSURLSessionDataTask *task, id responseObject) {
           
           if (![responseObject isKindOfClass:[NSError class]] || ![responseObject isKindOfClass:[NSNull class]]) {
               if ([responseObject isKindOfClass:[NSData class]]) {
                   NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                   NSLog(@"dict = %@",dict);
               }else if([responseObject isKindOfClass:[NSDictionary class]]){
                   
                   NSDictionary *respons = (NSDictionary *)responseObject;
                   NSArray *dataSources = [respons objectForKey:@"videos"];
                   [weakSelf.sourceArray removeAllObjects];
                   for (NSDictionary *dict in dataSources) {
                       VideoInfoModel *model = [VideoInfoModel ModelWithDict:dict];
                       [weakSelf.sourceArray addObject:model];
                   }
                   [weakSelf.tableView reloadData];
                   
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

- (void)setupPlayer:(NSURL *)url {
    
    _playerItem = [[AVPlayerItem alloc] initWithURL:url];
    _player = [AVPlayer playerWithPlayerItem:_playerItem];
    _playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
    _playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    [self.view.layer addSublayer:_playerLayer];
    _playerLayer.frame = self.view.bounds;
    
    [_player play];
}


- (NSArray *)NewsSource {
    if (!_NewsSource) {
        //1为最新新闻（大杂烩） 2（国内外新车） 3（评测） 4（导购） 5（行情）
        _NewsSource = @[@"最新",@"新车",@"评测",@"导购",@"行情"];
    }
    return _NewsSource;
}

- (NSMutableArray *)sourceArray {
    if (!_sourceArray) {
        _sourceArray = [NSMutableArray array];
    }
    return _sourceArray;
}

@end

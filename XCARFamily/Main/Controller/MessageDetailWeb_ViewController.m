//
//  MessageDetailWeb_ViewController.m
//  car_video
//
//  Created by imac on 2017/8/25.
//  Copyright © 2017年 self. All rights reserved.
//

#import "MessageDetailWeb_ViewController.h"
#import <WebKit/WKWebView.h>

@interface MessageDetailWeb_ViewController ()<WKUIDelegate,WKNavigationDelegate>

@property (nonatomic , strong) WKWebView *webView;
@property (nonatomic , strong) UIView *topView;
@property (nonatomic , strong) LoadingView_TypeOne *loadingView;
@property (nonatomic , strong) NSString *url;
@property (nonatomic , assign) BOOL isLodingCompelete;//是否加载完成

@end

@implementation MessageDetailWeb_ViewController

- (instancetype)initWithTitle:(NSString *)title {
    if (self = [super init]) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textColor = [UIColor grayColor];
//        _titleLabel.text = title;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    __weak typeof(self)wself = self;
    //头部导航栏:
    [self setupTopView];

    _webView = [[WKWebView alloc] initWithFrame:CGRectZero];
    _webView.backgroundColor = [UIColor whiteColor];
    _webView.UIDelegate = self;
    _webView.navigationDelegate = self;
    [self.view addSubview:_webView];
    [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.top.equalTo(wself.topView.mas_bottom);
        make.right.offset(0);
        make.bottom.offset(49);
    }];
    
    [self showHUD];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_url]]];
    });
}

- (void)backBtnAction:(UIButton *)btn {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - ---------------------加载WKWEBView------------------------

//开始加载:
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"开始加载");
    if (!_isLodingCompelete) {
        [self showHUD];
    }
}

//内容开始返回时:
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    NSLog(@"内容已经返回!!");
    [self hideHUD];
    _isLodingCompelete = YES;
}

//加载失败:
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"已经失败的加载");
    _isLodingCompelete = YES;
    [self hideHUD];
}

- (void)loadMsgWithURL:(NSString *)url {
    _url = url;
}

#pragma mark - ---------------------创建UI---------------------
- (void)setupTopView {
    self.navigationController.navigationBar.hidden = YES;
    UIView *topView = [[UIView alloc] init];
    _topView = topView;
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    
    [topView addSubview:_titleLabel];
    
    UIView *line = [[UIView alloc] init];
    [topView addSubview:line];
    line.backgroundColor = [UIColor lightGrayColor];
    
    UIButton *backBtn = [[UIButton alloc] init];
    _backButton = backBtn;
    
    [backBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [backBtn setTitleColor:colorsWithRGB(125, 204, 233) forState:UIControlStateHighlighted];
    [backBtn setImage:[UIImage imageNamed:@"顶部左上角返回按钮"] forState:UIControlStateNormal];
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [backBtn setBackgroundImage:[Tool imageWithColor:[UIColor whiteColor] size:CGSizeMake(1, 1)] forState:UIControlStateHighlighted];
    [backBtn addTarget:self action:@selector(backBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    [topView addSubview:backBtn];
    
    //布局子控件:
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.top.offset(20);
        make.right.offset(0);
        make.height.equalTo(@44);
    }];
    
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(5);
        make.width.equalTo(@80);
        make.top.offset(0);
        make.bottom.offset(-1);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.offset(0);
    }];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.right.offset(0);
        make.bottom.offset(0);
        make.height.equalTo(@1);
    }];
}

- (void)showHUD {
    if (!_loadingView) {
        _loadingView = [[LoadingView_TypeOne alloc] initWithView:self.view];
        [self.view addSubview:_loadingView];
        [_loadingView show:YES];
    }
}

- (void)hideHUD {
    [_loadingView hide:YES];
    _loadingView = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)dealloc {
    NSLog(@"网页界面已经销毁 --- >");
    [self hideHUD];
}

@end

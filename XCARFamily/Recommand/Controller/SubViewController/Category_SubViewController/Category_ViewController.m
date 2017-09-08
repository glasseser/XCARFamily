//
//  Category_ViewController.m
//  car_video
//
//  Created by custom on 16/12/20.
//  Copyright © 2016年 self. All rights reserved.
//

#import "Category_ViewController.h"
#import "Masonry.h"
#import "choiceCategory_View.h"

@interface Category_ViewController ()<CALayerDelegate>

@property (nonatomic , weak) UIButton *bgButton;
@property (nonatomic , weak) UILabel *contentLabel;
@property (nonatomic , weak) UIButton *closeBtn;
@property (nonatomic , weak) choiceCategory_View *categoryView;

@end

@implementation Category_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initOpacity];
    [self setupSubViews];
}

- (void)showActionAnimation {
    [UIView animateWithDuration:0.3 animations:^{
        self.bgButton.alpha = 0.2;
        self.contentLabel.frame = CGRectMake(0, 20, self.view.bounds.size.width, 44);
        self.closeBtn.frame = CGRectMake(self.view.bounds.size.width - 60, 20, 60, 44);
        self.categoryView.frame = CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height*0.7);
    }];
}

- (void)setupSubViews {
    UIButton *bgButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    self.bgButton = bgButton;
    bgButton.backgroundColor = [UIColor blackColor];
    bgButton.alpha = 0.0;
    [self.view addSubview:bgButton];
    [bgButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //下面的是移动cell的构建视图
    choiceCategory_View *categoryView = [[choiceCategory_View alloc] initWithFrame:CGRectMake(0, -self.view.bounds.size.height*0.7, self.view.bounds.size.width, self.view.bounds.size.height*0.7) choices:[resources_tool getChoiceSource] other:resources_tool.otherSource];
    [self.view addSubview:categoryView];
    self.categoryView = categoryView;
    categoryView.delegate = self;
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    
    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(-self.view.bounds.size.width, 20, self.view.bounds.size.width, 44)];
    self.contentLabel = contentLabel;
    [self.view addSubview:contentLabel];
    contentLabel.font = [UIFont systemFontOfSize:15];
    contentLabel.textColor = [UIColor grayColor];
    contentLabel.textAlignment = NSTextAlignmentLeft;
    contentLabel.text = [NSString stringWithFormat:@"%@",@"   已经选择的频道:"];
    contentLabel.backgroundColor = [UIColor whiteColor];
    
    UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width, 20, 60, 44)];
    self.closeBtn = closeBtn;
    [self.view addSubview:closeBtn];
    [closeBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [closeBtn setTitle:@"收起" forState:UIControlStateNormal];
    [closeBtn setTitleColor:colorsWithRGB(125, 204, 233) forState:UIControlStateNormal];
    closeBtn.titleLabel.font = [UIFont systemFontOfSize:13];
}

- (void)initOpacity {
    self.view.backgroundColor = [UIColor clearColor];
}

#pragma mark - ---------------------choiceCategory_ViewDelegate ------------------
- (void)choiceCategory_View:(choiceCategory_View *)categoryView btnClick:(UIButton *)btn {
    [self btnClick:btn];
}


#pragma mark - ----------------------按钮点击事件------------------------
//收起按钮点击事件和点击灰色部分触发事件
- (void)btnClick:(UIButton *)btn {
    
    if ([self.delegate respondsToSelector:@selector(Category_ViewController:didFinishedChooseCategory:)]){
        [self.categoryView.currentChoiceChannels insertObject:@"推荐" atIndex:0];
        
        [UIView animateWithDuration:0.3 animations:^{
            self.bgButton.alpha = 0.0;
            self.contentLabel.frame = CGRectMake(-self.view.bounds.size.width, 20, self.view.bounds.size.width, 44);
            self.closeBtn.frame = CGRectMake(self.view.bounds.size.width, 20, 60, 44);
            self.categoryView.frame = CGRectMake(0, -self.view.bounds.size.height*0.7, self.view.bounds.size.width, self.view.bounds.size.height*0.7);
        } completion:^(BOOL finished) {
            [self.delegate Category_ViewController:self
                         didFinishedChooseCategory:@{
                                 @"choiceChannels":[self.categoryView.currentChoiceChannels copy],
                                  @"otherChannels":[self.categoryView.otherChoiceChnnels copy]}];
        }];
    }
}

- (void)dealloc {
    NSLog(@"分类控制器销毁!!");
}


@end

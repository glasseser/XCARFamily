//
//  choiceCategory_View.h
//  car_video
//
//  Created by custom on 16/12/20.
//  Copyright © 2016年 self. All rights reserved.
//

#import <UIKit/UIKit.h>
@class choiceCategory_View;
@protocol choiceCategory_ViewDelegate <NSObject>

@optional
- (void)choiceCategory_View:(choiceCategory_View *)categoryView btnClick:(UIButton *)btn;

@end

@interface choiceCategory_View : UIView

@property (nonatomic , assign) CGFloat cell_borderMarin;//边界距离
@property (nonatomic , assign) CGFloat cell_verticalMargin;//垂直距离
@property (nonatomic , assign) CGFloat cell_horizonMargin;//水平距离
@property (nonatomic , assign) CGFloat cell_toDifferentViewMargin;//距离不同的view之间的距离
@property (nonatomic , assign) NSInteger moveCellFontSize;//cell的文字的大小
@property (nonatomic , weak) UILabel *moreChannelLabel;//更多频道label
@property (nonatomic , weak) UILabel *titleLabel;
@property (nonatomic , weak) id delegate;

@property (nonatomic , strong) NSMutableArray *currentChoiceChannels;//当前已经选择的频道
@property (nonatomic , strong) NSMutableArray *otherChoiceChnnels;//当前还没有进行选择的频道

- (instancetype)initWithFrame:(CGRect)frame choices:(NSArray *)choices other:(NSArray *)others;


@end

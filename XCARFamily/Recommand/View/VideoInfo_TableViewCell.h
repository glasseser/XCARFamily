//
//  VideoInfo_TableViewCell.h
//  CARFamily
//
//  Created by imac on 2017/9/1.
//  Copyright © 2017年 GuangZhouWeiControl. All rights reserved.
//

#import <UIKit/UIKit.h>
@class VideoInfoModel;

@interface VideoInfo_TableViewCell : UITableViewCell

@property (nonatomic , strong) UIImageView *iconView;
@property (nonatomic , strong) UIImageView *playView;
@property (nonatomic , strong) UIView *play_bg;

- (void)bindModel:(VideoInfoModel *)model;

@end

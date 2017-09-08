//
//  VideoInfo_TableViewCell.m
//  CARFamily
//
//  Created by imac on 2017/9/1.
//  Copyright © 2017年 GuangZhouWeiControl. All rights reserved.
//

#import "VideoInfo_TableViewCell.h"
#import "UIImage+AFNetworking.h"
#import "VideoInfoModel.h"
#import "Masonry.h"

@interface VideoInfo_TableViewCell ()

@property (nonatomic , strong) UILabel *titleLabel;//内容描述
@property (nonatomic , strong) UILabel *playCount;//播放数
@property (nonatomic , strong) UILabel *commentLabel;//评论
@property (nonatomic , strong) UILabel *dateLabel;//日期
@property (nonatomic , strong) UILabel *playTimes;//播放时间

@end

@implementation VideoInfo_TableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupSubViews];
    }
    return self;
}

- (void)bindModel:(VideoInfoModel *)model {
    [_iconView sd_setImageWithURL:[NSURL URLWithString:model.image_url]];
//    __weak typeof(self)wself = self;
//    [_iconView sd_setImageWithURL:[NSURL URLWithString:model.image_url] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        wself.iconView.image = image;
//    }];
    
    _titleLabel.text = model.title;
    _playCount.text = [NSString stringWithFormat:@"%ld次播放",model.playCount];
    _commentLabel.text = [NSString stringWithFormat:@"%ld评论",model.commentCount];
    _dateLabel.text = [NSString stringWithFormat:@"%@",model.dely_date];
    _playTimes.text = [NSString stringWithFormat:@"%@",model.turn_duration];
}

- (void)setupSubViews {
    
    __weak typeof(self)wself = self;
    
    _iconView = [[UIImageView alloc] init];
    [self.contentView addSubview:_iconView];
    UIView *bg = [[UIView alloc] init];
    [self.contentView addSubview:bg];
    bg.backgroundColor = [UIColor blackColor];
    bg.alpha = 0.3;
    bg.layer.masksToBounds = YES;
    bg.layer.cornerRadius = 1;
    
    CGSize imgSize = [[UIImage imageNamed:@"摄像头_播放"] size];
    CGFloat play_bg_w = imgSize.width+20;
    UIView *play_bg = [[UIView alloc] init];
    _play_bg = play_bg;
    [self.contentView addSubview:play_bg];
    play_bg.backgroundColor = [UIColor blackColor];
    play_bg.alpha = 0.1;
    play_bg.layer.masksToBounds = YES;
    play_bg.layer.cornerRadius = play_bg_w*0.5;
    
    _playView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"摄像头_播放"]];
    [self.contentView addSubview:_playView];
    
    _iconView.backgroundColor = [UIColor lightGrayColor];
    _titleLabel = [self createLabelWithTitle:nil txtColor:[UIColor blackColor] font:16];
    _titleLabel.numberOfLines = 2;
    _playCount = [self createLabelWithTitle:nil txtColor:[UIColor lightGrayColor] font:12];
    _commentLabel = [self createLabelWithTitle:nil txtColor:[UIColor lightGrayColor] font:12];
    _dateLabel = [self createLabelWithTitle:nil txtColor:[UIColor lightGrayColor] font:12];
    _playTimes = [self createLabelWithTitle:nil txtColor:[UIColor whiteColor] font:12];
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor lightGrayColor];
    line.alpha = 0.3;
    [self.contentView addSubview:line];
    
    [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.top.offset(5);
        make.right.offset(0);
        make.height.equalTo(@(wself.contentView.bounds.size.width/200*112));
    }];
    [_playView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(wself.iconView);
    }];
    
    [_playTimes mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(wself.iconView.mas_bottom).offset(-3);
        make.right.equalTo(wself.iconView.mas_right).offset(-4);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.top.equalTo(wself.iconView.mas_bottom).offset(5);
        make.right.offset(0);
        make.height.equalTo(@20);
    }];
    
    [_playCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wself.titleLabel);
        make.top.equalTo(wself.titleLabel.mas_bottom).offset(0);
        make.bottom.offset(0);
    }];
    
    [_commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wself.playCount.mas_right).offset(5);
        make.centerY.equalTo(wself.playCount);
    }];
    
    [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-5);
        make.centerY.equalTo(wself.commentLabel);
    }];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.offset(0);
        make.height.equalTo(@0.8);
    }];
    [bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(wself.playTimes);
        make.width.equalTo(wself.playTimes).offset(4);
        make.height.equalTo(wself.playTimes).offset(4);
    }];
    
    [play_bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(wself.playView).offset(-2);
        make.centerY.equalTo(wself.playView);
        make.width.and.height.equalTo(@(play_bg_w));
    }];
}

- (UILabel *)createLabelWithTitle:(NSString *)title
                         txtColor:(UIColor *)txtColor
                             font:(CGFloat)fontSize {
    
    UILabel *label = [[UILabel alloc] init];
    label.textColor = txtColor;
    label.font = [UIFont systemFontOfSize:fontSize];
    [self.contentView addSubview:label];
    label.text = title;
    return label;
}

@end

//
//  CarBrandInfo_TableViewCell.m
//  car_video
//
//  Created by imac on 2017/8/28.
//  Copyright © 2017年 self. All rights reserved.
//

#import "CarBrandInfo_TableViewCell.h"
#import "CarBrandModel.h"
#import "Masonry.h"

@interface CarBrandInfo_TableViewCell ()

@property (nonatomic , strong) UIImageView *icon;
@property (nonatomic , strong) UILabel *contentLabel;

@end

@implementation CarBrandInfo_TableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupSubViews];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)bindModel:(id)model {
    
    __weak typeof(self)wself = self;
    NSString *url = @"";
    if ([model isKindOfClass:[CarBrandModel class]]) {
        url = [(CarBrandModel *)model icon];
    }
    
    [_icon sd_setImageWithURL:[NSURL URLWithString:url] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        wself.icon.image = image;
    }];
    
    if ([model isKindOfClass:[CarBrandModel class]]) {
        self.contentLabel.text = [(CarBrandModel *)model name];
    }else{
        self.contentLabel.text = @"";
    }
}

- (void)setupSubViews {
    __weak typeof(self)wself = self;
    _icon = [[UIImageView alloc] initWithImage:[Tool imageWithColor:[UIColor lightGrayColor] size:CGSizeMake(1, 1)]];
    [self.contentView addSubview:_icon];
    
    _contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:_contentLabel];
    _contentLabel.font = [UIFont systemFontOfSize:16];
    _contentLabel.textColor = [UIColor grayColor];
    
    [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.top.offset(10);
        make.bottom.offset(-10);
        make.width.mas_equalTo(wself.icon.mas_height).multipliedBy(4.0/3.0);  //160x120 , 图片大小自己根据资源路径获取后判断
    }];
    
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(wself.icon);
        make.left.equalTo(wself.icon.mas_right).offset(10);
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end

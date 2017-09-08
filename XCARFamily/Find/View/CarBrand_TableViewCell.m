//
//  CarBrand_TableViewCell.m
//  CARFamily
//
//  Created by imac on 2017/8/29.
//  Copyright © 2017年 GuangZhouWeiControl. All rights reserved.
//

#import "CarBrand_TableViewCell.h"
#import "CarBrandDetailModel.h"

@interface CarBrand_TableViewCell ()

@property (nonatomic , strong) UIImageView *iconView;
@property (nonatomic , strong) UILabel *brand;
@property (nonatomic , strong) UILabel *price;

@end

@implementation CarBrand_TableViewCell

- (void)bindModel:(CarBrandDetailModel *)model {
    __weak typeof(self)wself = self;
    [_iconView sd_setImageWithURL:[NSURL URLWithString:model.seriesIcon] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        wself.iconView.image = image;
    }];
    
    _brand.text = model.seriesName;
    _price.text = model.seriesPrice;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {
    __weak typeof(self)wself = self;
    _iconView = [[UIImageView alloc] initWithImage:[Tool imageWithColor:[UIColor lightGrayColor] size:CGSizeMake(1, 1)]];
    [self.contentView addSubview:_iconView];
    
    _brand = [[UILabel alloc] initWithFrame:CGRectZero];
    _brand.textColor = [UIColor blackColor];
    _brand.font = [UIFont systemFontOfSize:18];
    [self.contentView addSubview:_brand];
    
    _price = [[UILabel alloc] initWithFrame:CGRectZero];
    _price.textColor = colorsWithRGB(237,92,40);//237 92 40
    _price.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_price];
    
    [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.top.offset(10);
        make.bottom.offset(-10);
        make.width.mas_equalTo(wself.iconView.mas_height).multipliedBy(180.0/135);
    }];
    
    [_brand mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wself.iconView);
        make.bottom.equalTo(wself.iconView.mas_centerY);
        make.left.equalTo(wself.iconView.mas_right).offset(10);
        make.right.offset(0);
    }];
    
    [_price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wself.iconView.mas_centerY);
        make.bottom.equalTo(wself.iconView);
        make.left.equalTo(wself.iconView.mas_right).offset(10);
        make.right.offset(0);
    }];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectZero];
    line.backgroundColor = [UIColor lightGrayColor];
    line.alpha = 0.6;
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.right.offset(0);
        make.bottom.offset(0);
        make.height.equalTo(@0.5);
    }];
}

@end

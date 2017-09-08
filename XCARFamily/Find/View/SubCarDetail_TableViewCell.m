//
//  SubCarDetail_TableViewCell.m
//  CARFamily
//
//  Created by imac on 2017/8/31.
//  Copyright © 2017年 GuangZhouWeiControl. All rights reserved.
//

#import "SubCarDetail_TableViewCell.h"
#import "SubCarDetail_Cars_Model.h"
#import "Masonry.h"

@interface SubCarDetail_TableViewCell ()

@property (nonatomic , strong) UILabel *title;
@property (nonatomic , strong) UILabel *lowPrice;
@property (nonatomic , strong) UILabel *guideTip;
@property (nonatomic , strong) UILabel *guidePrice;

@property (nonatomic , strong) UILabel *driver; //驱动
@property (nonatomic , strong) UILabel *transmission; //离合

@end

@implementation SubCarDetail_TableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initOpacity];
        [self setupSubViews];
    }
    return self;
}

- (void)bindModel:(SubCarDetail_Cars_Model *)model {
    /*
     "carName"
     "subSeriesName"
     */
    /*
     {
     "carId": 35336,
     "carName": "35 TFSI 风尚型",
     "subSeriesId": "8613",
     "subSeriesName": "2017款奥迪A3两厢",
     "guidePrice": "23.25 万",
     "engine": "1.4T",
     "transmission": "双离合变速箱",
     "driver": "前置前驱",
     "lowestPrice": "23.25 万"
     }
     */
    _title.text = [NSString stringWithFormat:@"%@ %@",model.subSeriesName,model.carName];
    _lowPrice.text = [NSString stringWithFormat:@"厂商指导价:\t%@",model.lowestPrice];
    _guidePrice.text = [NSString stringWithFormat:@"%@",model.guidePrice];
    _driver.text = model.driver;
    _transmission.text = model.transmission;
}

- (void)setupSubViews {
    __weak typeof(self)wself = self;
    
    CGFloat margin = 8;
    CGFloat distance = 10;
    
    _title = [[UILabel alloc] init];
    [self.contentView addSubview:_title];
    _title.font = [UIFont systemFontOfSize:18];
    _title.textColor = [UIColor blackColor];
//    CGSize labelSize = [@"" sizeWithAttribute:@{}];
    
    _lowPrice = [[UILabel alloc] init];
    [self.contentView addSubview:_lowPrice];
    _lowPrice.font = [UIFont systemFontOfSize:14];
    _lowPrice.textColor = [UIColor lightGrayColor];
    
    _guideTip = [[UILabel alloc] init];
    [self.contentView addSubview:_guideTip];
    _guideTip.font = [UIFont systemFontOfSize:14];
    _guideTip.textColor = [UIColor lightGrayColor];
    _guideTip.text = [NSString stringWithFormat:@"参考价:\t"];
    
    _guidePrice = [[UILabel alloc] init];
    [self.contentView addSubview:_guidePrice];
    _guidePrice.font = [UIFont systemFontOfSize:18];
    _guidePrice.textColor = colorsWithRGB(237,92,40);
    
    _driver = [[UILabel alloc] init];
    [self.contentView addSubview:_driver];
    _driver.font = [UIFont systemFontOfSize:14];
    _driver.textColor = [UIColor lightGrayColor];
    
    _transmission = [[UILabel alloc] init];
    [self.contentView addSubview:_transmission];
    _transmission.font = [UIFont systemFontOfSize:14];
    _transmission.textColor = [UIColor lightGrayColor];
    
    UIView *line = [[UIView alloc] init];
    [self.contentView addSubview:line];
    line.backgroundColor = [UIColor lightGrayColor];
    line.alpha = 0.3;
    
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(distance);
        make.top.offset(distance);
        make.right.offset(-distance);
    }];
    [_driver mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wself.title);
        make.top.equalTo(wself.title.mas_bottom).offset(margin);
    }];
    
    [_transmission mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wself.driver);
        make.top.equalTo(wself.driver.mas_bottom).offset(margin);
    }];
    
    [_lowPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wself.transmission);
        make.top.equalTo(wself.transmission.mas_bottom).offset(margin);
    }];
    
    [_guideTip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(wself.guidePrice.mas_left).offset(5);
        make.centerY.equalTo(wself.lowPrice);
    }];
    
    [_guidePrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(wself.guideTip);
        make.right.offset(-distance);
    }];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.right.offset(0);
        make.bottom.offset(0);
        make.height.equalTo(@0.7);
    }];
}

- (void)initOpacity {
    self.contentView.backgroundColor = [UIColor  whiteColor];
}

@end

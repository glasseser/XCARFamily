//
//  headScan_CollectionViewCell.m
//  car_video
//
//  Created by custom on 16/12/17.
//  Copyright © 2016年 self. All rights reserved.
//

#import "headScan_CollectionViewCell.h"

@implementation headScan_CollectionViewCell

- (void)bindURL:(NSString *)URL {
    __weak typeof(self)weakSelf = self;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:URL]
                     placeholderImage:[Tool imageWithColor:[UIColor grayColor]
                                                      size:CGSizeMake(1, 1)]
                            completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image){
            weakSelf.iconView.image = image;
        }
    }];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {
    UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.iconView = iconView;
    [self.contentView addSubview:iconView];
    
    iconView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:iconView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:iconView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:iconView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:iconView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0]];
}

@end

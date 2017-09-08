//
//  recommandTop_CollectionViewCell.m
//  car_video
//
//  Created by custom on 16/12/19.
//  Copyright © 2016年 self. All rights reserved.
//

#import "recommandTop_CollectionViewCell.h"

@implementation recommandTop_CollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]){
        [self setupSubViews];
        self.contentView.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setupSubViews
{
    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.contentLabel = contentLabel;
    [self.contentView addSubview:contentLabel];
    contentLabel.textColor = [UIColor grayColor];
    contentLabel.textAlignment = NSTextAlignmentCenter;
    contentLabel.font = [UIFont systemFontOfSize:14];
    contentLabel.backgroundColor = [UIColor clearColor];
    
    contentLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:contentLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:contentLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:contentLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:contentLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
}

@end

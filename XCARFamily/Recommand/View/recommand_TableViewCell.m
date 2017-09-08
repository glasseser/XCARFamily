//
//  recommand_TableViewCell.m
//  car_video
//
//  Created by custom on 16/12/9.
//  Copyright © 2016年 self. All rights reserved.
//

#import "recommand_TableViewCell.h"
#import "recommandMsg_Model.h"

@implementation recommand_TableViewCell

- (void)bindModel:(recommandMsg_Model *)model
{
    __weak typeof(self)weakSelf = self;
    self.titleLabel.text = model.title;
    self.timeLabel.text = model.time;
    self.replyLabel.text = [NSString stringWithFormat:@"评论: %ld",model.replycount];
    
    NSString *carSmallString = model.smallpic;
    NSString *httpString = [carSmallString substringToIndex:4];
    NSString *otherString = [carSmallString substringFromIndex:4];
    NSString *theWholeString = [NSString stringWithFormat:@"%@s%@",httpString,otherString];
    NSURL *url = [NSURL URLWithString:theWholeString];
    [self.iconView sd_setImageWithURL:url placeholderImage:[Tool imageWithColor:[UIColor grayColor] size:CGSizeMake(1, 1)] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
       
        if (image){
            weakSelf.iconView.image = image;
        }else{
            if (error){
                NSLog(@"error = %@",error);
            }
        }
        
    }];
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]){
        [self setupSubViews];
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews
{
    CGFloat margin = 5;
    self.iconView = [Tool imgViewWithTag:1
                                   toView:self.contentView
                                 placeImg:nil
                         autoMaskContaint:NO
                                 containt:nil];
    self.iconView.backgroundColor = [UIColor lightGrayColor];
    
    self.titleLabel = [Tool labelWithTag:2
                                  toView:self.contentView
                                    font:16
                               textColor:[UIColor darkGrayColor]
                        autoMaskContaint:NO
                                containt:nil];
    self.titleLabel.numberOfLines = 2;
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.iconView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:margin]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.iconView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-margin]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.iconView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:margin]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.iconView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.iconView attribute:NSLayoutAttributeHeight multiplier:1.4 constant:0]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.iconView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.iconView attribute:NSLayoutAttributeRight multiplier:1.0 constant:margin]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-margin]];
    [self.titleLabel sizeToFit];
    
    [self setUpOthers];
}

- (void)setUpOthers {
    self.timeLabel = [Tool labelWithTag:2
                                 toView:self.contentView
                                   font:13
                              textColor:[UIColor lightGrayColor]
                       autoMaskContaint:NO
                               containt:nil];
    
    /*
     ** relayLabel
     */
    self.replyLabel = [Tool labelWithTag:2
                                  toView:self.contentView
                                    font:13
                               textColor:[UIColor lightGrayColor]
                        autoMaskContaint:NO
                                containt:nil];
    
    CGFloat margin = 5;
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.timeLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.iconView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.timeLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.iconView attribute:NSLayoutAttributeRight multiplier:1.0 constant:margin]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.timeLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-margin]];
    [self.timeLabel sizeToFit];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.replyLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.timeLabel attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.replyLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-margin]];
    [self.replyLabel sizeToFit];
}


@end

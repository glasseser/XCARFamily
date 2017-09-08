//
//  recommand_TableViewCell.h
//  car_video
//
//  Created by custom on 16/12/9.
//  Copyright © 2016年 self. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@class recommandMsg_Model;

@interface recommand_TableViewCell : UITableViewCell

@property (nonatomic , weak) UIImageView *iconView;
@property (nonatomic , weak) UILabel *titleLabel;
@property (nonatomic , weak) UILabel *timeLabel;
@property (nonatomic , weak) UILabel *replyLabel;

- (void)bindModel:(recommandMsg_Model *)model;
- (void)setUpOthers;

@end

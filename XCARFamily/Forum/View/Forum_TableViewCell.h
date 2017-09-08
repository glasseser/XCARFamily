//
//  Forum_TableViewCell.h
//  car_video
//
//  Created by imac on 2017/8/26.
//  Copyright © 2017年 self. All rights reserved.
//

#import "recommand_TableViewCell.h"

@class ForumsModel;

@interface Forum_TableViewCell : recommand_TableViewCell

- (void)bindModel:(ForumsModel *)model;

@end

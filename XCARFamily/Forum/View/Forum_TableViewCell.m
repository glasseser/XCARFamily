//
//  Forum_TableViewCell.m
//  car_video
//
//  Created by imac on 2017/8/26.
//  Copyright © 2017年 self. All rights reserved.
//

#import "Forum_TableViewCell.h"
#import "ForumsModel.h"

@interface Forum_TableViewCell ()

@end

@implementation Forum_TableViewCell

- (void)bindModel:(ForumsModel *)model {
    __weak typeof(self)wself = self;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https:%@",model.postImage]] placeholderImage:[Tool imageWithColor:[UIColor grayColor] size:CGSizeMake(1, 1)] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        if (image){
            wself.iconView.image = image;
        }else{
            if (error){
                NSLog(@"error = %@",error);
            }
        }
        
    }];
    self.titleLabel.text = model.postTitle;
    self.timeLabel.text = model.forumName;
    self.replyLabel.text = [NSString stringWithFormat:@"评论:%ld",model.replyCount];
}

//- (void)setUpOthers {
//    
//}

@end

//
//  headScan_CollectionViewCell.h
//  car_video
//
//  Created by custom on 16/12/17.
//  Copyright © 2016年 self. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface headScan_CollectionViewCell : UICollectionViewCell

@property (nonatomic , weak) UIImageView *iconView;

- (void)bindURL:(NSString *)URL;

@end

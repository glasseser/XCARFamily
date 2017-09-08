//
//  moveCell.h
//  car_video
//
//  Created by custom on 16/12/21.
//  Copyright © 2016年 self. All rights reserved.
//

#import <UIKit/UIKit.h>

@class moveCell;

@protocol moveCellDelegate <NSObject>

@optional
- (void)moveCell:(moveCell *)moveCell touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event;
- (void)moveCell:(moveCell *)moveCell touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event;
- (void)moveCell:(moveCell *)moveCell touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event;

@end

@interface moveCell : UIView

@property (nonatomic , assign) BOOL moveCellIsMoving;

@property (nonatomic , strong) NSIndexPath *position;
//@property (nonatomic , assign) NSInteger position;
@property (nonatomic , assign) NSInteger destinationPosition;

@property (nonatomic , weak) id<moveCellDelegate> delegate;
@property (nonatomic , weak) UILabel *textLabel;

@end

//
//  moveCell.m
//  car_video
//
//  Created by custom on 16/12/21.
//  Copyright © 2016年 self. All rights reserved.
//

#import "moveCell.h"

@implementation moveCell

- (void)drawRect:(CGRect)rect {
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]){
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews
{
    UILabel *v = [[UILabel alloc] initWithFrame:self.bounds];
    
    [self addSubview:v];
    v.backgroundColor = [UIColor clearColor];
    v.textColor = colorsWithRGB(175, 180, 186);
    v.font = [UIFont systemFontOfSize:13];
    v.textAlignment = NSTextAlignmentCenter;
    self.textLabel = v;
    
    _destinationPosition = -1;
    self.layer.masksToBounds = YES;
    self.moveCellIsMoving = NO;
    [self.layer setBorderColor:colorsWithSameRGB(241).CGColor];
    [self.layer setBorderWidth:1.0];
    self.layer.cornerRadius = 3;
    self.backgroundColor = colorsWithSameRGB(248);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if ([self.delegate respondsToSelector:@selector(moveCell:touchesBegan:withEvent:)]){
        [self.delegate moveCell:self touchesBegan:touches withEvent:event];
        self.textLabel.frame = self.bounds;
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if ([self.delegate respondsToSelector:@selector(moveCell:touchesEnded:withEvent:)]){
        [self.delegate moveCell:self touchesEnded:touches withEvent:event];
        self.textLabel.frame = self.bounds;
    }
    self.moveCellIsMoving = NO;
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if ([self.delegate respondsToSelector:@selector(moveCell:touchesMoved:withEvent:)]){
        [self.delegate moveCell:self touchesMoved:touches withEvent:event];
    }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self touchesEnded:touches withEvent:event];
}

- (void)dealloc
{
    NSLog(@"moveCell已经销毁了!!");
}


@end

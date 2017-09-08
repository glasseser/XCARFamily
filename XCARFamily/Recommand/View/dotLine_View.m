//
//  dotLine_View.m
//  car_video
//
//  Created by custom on 16/12/22.
//  Copyright © 2016年 self. All rights reserved.
//

#import "dotLine_View.h"

@implementation dotLine_View

- (void)drawRect:(CGRect)rect
{
/*
 CGContextRef context = UIGraphicsGetCurrentContext();
 //设置线条样式
 CGContextSetLineCap(context, kCGLineCapSquare);
 //设置线条粗细宽度
 CGContextSetLineWidth(context, 1.0);
 //设置颜色
 CGContextSetRGBStrokeColor(context, 1.0, 0.0, 0.0, 1.0);
 //开始一个起始路径
 CGContextBeginPath(context);
 //起始点设置为(0,0):注意这是上下文对应区域中的相对坐标
 CGContextMoveToPoint(context, 0, 0);
 //设置下一个坐标点
 CGContextAddLineToPoint(context, 100, 100);
 //设置下一个坐标点
 CGContextAddLineToPoint(context, 0, 150);
 //设置下一个坐标点
 CGContextAddLineToPoint(context, 50, 180);
 //连接上面定义的坐标点
 CGContextStrokePath(context);
 */
    

     [super drawRect:rect];
     CGContextRef currentContext = UIGraphicsGetCurrentContext();
     //设置虚线颜色
     CGContextSetStrokeColorWithColor(currentContext, [UIColor blackColor].CGColor);
     //设置虚线宽度
     CGContextSetLineWidth(currentContext, 1);
     //设置虚线绘制起点
     CGContextMoveToPoint(currentContext, 0, 0);
     //设置虚线绘制终点
     CGContextAddLineToPoint(currentContext, self.frame.origin.x + self.frame.size.width, 0);
     //设置虚线排列的宽度间隔:下面的arr中的数字表示先绘制3个点再绘制1个点
     CGFloat arr[] = {5,1};
     //下面最后一个参数“2”代表排列的个数。
     CGContextSetLineDash(currentContext, 0, arr, 2);
     CGContextDrawPath(currentContext, kCGPathStroke);

}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor whiteColor];
        [self drawDotLineBorder:colorsWithSameRGB(208)];
    }
    return self;
}

/*
 ** 画虚线 , 横向排布
 */
- (void)drawDotLineToView:(UIView *)lineView lineColor:(UIColor *)lineColor lineSpacing:(CGFloat)lineSpacing lineLength:(CGFloat)lineLength
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:lineView.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame))];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:lineColor.CGColor];
    //  设置虚线宽度
    [shapeLayer setLineWidth:CGRectGetHeight(lineView.frame)];
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL,CGRectGetWidth(lineView.frame), 0);
    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [lineView.layer addSublayer:shapeLayer];
}

/*
 ** 话虚线边框
 */
- (void)drawDotLineBorder:(UIColor *)SLColorLine
{
    CAShapeLayer *border = [CAShapeLayer layer];
    
    border.strokeColor = SLColorLine.CGColor;
    
    border.fillColor = nil;
    
    border.path = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
    
    border.frame = self.bounds;
    
    border.lineWidth = 0.8;
    
    border.lineCap = @"square";
    
    border.lineDashPattern = @[@4, @2];
    
    [self.layer addSublayer:border];
}

@end

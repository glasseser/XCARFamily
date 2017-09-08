//
//  LoadingView_TypeOne.m
//  CARFamily
//
//  Created by imac on 2017/8/30.
//  Copyright © 2017年 GuangZhouWeiControl. All rights reserved.
//

#import "LoadingView_TypeOne.h"

@interface LoadingView_TypeOne ()

@property (nonatomic , strong) NSTimer *timer;
@property (nonatomic , strong) UIView *borderView;
@property (nonatomic , strong) UIColor *FirstDotColor;
@property (nonatomic , strong) UIColor *SecondDotColor;
@property (nonatomic , strong) UIColor *ThirdDotColor;
@property (nonatomic , assign) NSInteger index;
@property (nonatomic , assign) CGFloat borderViewAngle;
@property (nonatomic , assign) NSInteger calculateIndex;

@property (nonatomic , strong) dispatch_queue_t queue_a;
@property (nonatomic , strong) dispatch_group_t group_t;

@end

@implementation LoadingView_TypeOne

- (void)drawRect:(CGRect)rect {
    
//    /*
//     将改视图分为3：1，共4份，上面的3份是显示圆角矩形，下面的1份显示的是文字
//     */
//    
//    /*
//     
//     */
//    
//    CGFloat width = _BorderWidth;
//    CGFloat height = _BorderHeight;
//    CGFloat center_x = self.bounds.size.width*0.5;
//    CGFloat center_y = self.bounds.size.height*0.5;
//    CGFloat margin = sin(45)*width*0.5;
//
//    //上下文
//    CGContextRef ctx = UIGraphicsGetCurrentContext();
//
//    [_borderColor set];
//    CGContextSetLineWidth(ctx, 1.6);
//    
//    CGFloat radius = 5;
//    CGFloat cor = sqrtf(powf(width*0.5, 2)+powf(height*0.5, 2));
//    CGFloat arc_cor = cor-sqrtf(powf(radius*0.5, 2)+powf(radius*0.5, 2));//cor-radius;
//    CGFloat angle = M_PI/4;
//    
//    //point
//    CGFloat right_top_x = center_x+cor*cos(angle);
//    CGFloat right_top_y = center_y-cor*sin(angle);
//    CGFloat left_top_x = center_x+cor*cos(angle+M_PI_2);
//    CGFloat left_top_y = center_y-cor*sin(angle+M_PI_2);
//    
//    CGFloat right_bottom_x = center_x+cor*cos(angle-M_PI_2);
//    CGFloat right_bottom_y = center_y-cor*sin(angle-M_PI_2);
//    CGFloat left_bottom_x = center_x+cor*cos(angle+M_PI);
//    CGFloat left_bottom_y = center_y-cor*sin(angle+M_PI);
//    
//    //arc
//    CGFloat right_top_arc_x = center_x+arc_cor*cos(angle);
//    CGFloat right_top_arc_y = center_y-arc_cor*sin(angle);
//    CGFloat left_top_arc_x = center_x+arc_cor*cos(angle+M_PI_2);
//    CGFloat left_top_arc_y = center_y-arc_cor*sin(angle+M_PI_2);
//    
//    CGFloat right_bottom_arc_x = center_x+arc_cor*cos(angle-M_PI_2);
//    CGFloat right_bottom_arc_y = center_y-arc_cor*sin(angle-M_PI_2);
//    CGFloat left_bottom_arc_x = center_x+arc_cor*cos(angle+M_PI);
//    CGFloat left_bottom_arc_y = center_y-arc_cor*sin(angle+M_PI);
//    
//    CGFloat arc_x_margin = radius*cos(angle);
//    CGFloat arc_y_margin = radius*sin(angle);
//    
//    CGContextMoveToPoint(ctx, left_top_arc_x, left_top_y);
//    CGContextAddLineToPoint(ctx, right_top_arc_x, right_top_y);
//    
//    CGFloat arc_angle = 2*M_PI-M_PI/4+angle;
//    //右上角圆角
//    CGContextAddArc(ctx, right_top_arc_x, right_top_arc_y, radius, -0.5*M_PI+arc_angle, 0.0+arc_angle, 0);
    
//    CGContextAddLineToPoint(ctx, right_bottom_x, right_bottom_arc_y);
//    //右下角圆角
//    CGContextAddArc(ctx, right_bottom_arc_x, right_bottom_arc_y, radius, 0.0+angle, 0.5*M_PI+angle, 0);
//
//    CGContextAddLineToPoint(ctx, left_bottom_arc_x, left_bottom_y);
//    //左下角圆角
//    CGContextAddArc(ctx, left_bottom_arc_x, left_bottom_arc_y, radius, 0.5*M_PI+angle, M_PI+angle, 0);
//
//    //左上角圆角
//    CGContextAddLineToPoint(ctx, left_top_x, left_top_arc_y);
//    CGContextAddArc(ctx, left_top_arc_x, left_top_arc_y, radius, M_PI+angle, 1.5*M_PI+angle, 0);
    
//    CGContextStrokePath(ctx);
    
//    CGFloat left_top_x = center_x-width*0.5;
//    CGFloat left_top_y = center_y-height*0.5;
//    CGFloat left_bottom_x = left_top_x;
//    CGFloat left_bottom_y = left_top_y+height*0.5;
//    CGFloat right_top_x = left_top_x+width*0.5;
//    CGFloat right_top_y = left_top_y;
//    CGFloat right_bottom_x = right_top_x;
//    CGFloat right_bottom_y = left_bottom_y;
//    //将圆角半径设置为指定的长和宽的1/10
//    CGFloat radius = 5;
//    
//    //上下文
//    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    
//    [_borderColor set];
//    CGContextSetLineWidth(ctx, 1.6);
//    
//    //顺时针画
//    CGContextMoveToPoint(ctx, left_top_x+radius, left_top_y);
//    CGContextAddLineToPoint(ctx, right_top_x-radius, right_top_y);
//    
//    //右上角圆角
//    CGContextAddArc(ctx, right_top_x-radius, right_top_y+radius, radius, -0.5*M_PI, 0.0, 0);
//    
//    CGContextAddLineToPoint(ctx, right_top_x, right_bottom_y-radius);
//    //右下角圆角
//    CGContextAddArc(ctx, right_bottom_x-radius, right_bottom_y-radius, radius, 0.0, 0.5*M_PI, 0);
//    
//    CGContextAddLineToPoint(ctx, left_bottom_x+radius, left_bottom_y);
//    //左下角圆角
//    CGContextAddArc(ctx, left_bottom_x+radius, left_bottom_y-radius, radius, 0.5*M_PI, M_PI, 0);
//
//    //左上角圆角
//    CGContextAddLineToPoint(ctx, left_top_x, left_top_y+radius);
//    CGContextAddArc(ctx, left_top_x+radius, left_top_y+radius, radius, M_PI, 1.5*M_PI, 0);
    
//    CGContextStrokePath(ctx);
    
    CGSize contentSize = [_txt sizeWithAttributes:@{NSFontAttributeName : _txtFont}];
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [_txtColor set];
    
    //文字
    [_txt drawAtPoint:CGPointMake(_borderView.center.x-contentSize.width*0.5, _borderView.center.y+_BorderHeight) withAttributes:@{NSFontAttributeName:_txtFont,NSForegroundColorAttributeName:_txtColor}];
    //点
    CGFloat first_dot_x = _borderView.center.x+contentSize.width*0.5;
    CGFloat dot_y = _borderView.center.y+_BorderHeight;
    CGSize dot_size = [@"." sizeWithAttributes:@{NSFontAttributeName:_txtFont,NSForegroundColorAttributeName:_txtColor}];
    [@"." drawInRect:CGRectMake(first_dot_x, dot_y, dot_size.width, dot_size.height) withAttributes:@{NSFontAttributeName:_txtFont,NSForegroundColorAttributeName:_FirstDotColor}];
    [@"." drawInRect:CGRectMake(first_dot_x+dot_size.width, dot_y, dot_size.width, dot_size.height) withAttributes:@{NSFontAttributeName:_txtFont,NSForegroundColorAttributeName:_SecondDotColor}];
    [@"." drawInRect:CGRectMake(first_dot_x+dot_size.width*2, dot_y, dot_size.width, dot_size.height) withAttributes:@{NSFontAttributeName:_txtFont,NSForegroundColorAttributeName:_ThirdDotColor}];
    
    CGContextFillPath(ctx);
}

- (instancetype)initWithView:(UIView *)superView {
    if (self = [super initWithFrame:superView.bounds]) {
        [self initOpacity];
        [self setupSubViews];
    }
    return self;
}

- (instancetype)initWithWindow:(UIWindow *)win {
    if (self = [super initWithFrame:win.bounds]) {
        [self initOpacity];
        [self setupSubViews];
    }
    return self;
}

- (void)initOpacity {
    _borderColor = colorsWithSameRGB(108);
    _txtColor = colorsWithSameRGB(108);
    _dotHighLightColor = colorsWithSameRGB(151);
    _dotNormalColor = colorsWithSameRGB(78);
    _txtFont = [UIFont systemFontOfSize:14];
    _BorderWidth = 16;
    _txt = @"加载中";
    _BorderHeight = _BorderWidth;
    self.backgroundColor = [UIColor clearColor];
    
    _FirstDotColor = _dotNormalColor;
    _SecondDotColor = _dotNormalColor;
    _ThirdDotColor = _dotHighLightColor;
    _index = 3;
    _calculateIndex = 0;
    _borderViewAngle = M_PI/12;
    
    self.queue_a = dispatch_queue_create("LoadingViewQueue", 0);
    self.group_t = dispatch_group_create();
}

- (void)setupSubViews {
    _borderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _BorderWidth, _BorderHeight)];
    [self addSubview:_borderView];
    [_borderView.layer setBorderColor:_borderColor.CGColor];
    [_borderView.layer setBorderWidth:1.8];
    _borderView.layer.masksToBounds = YES;
    _borderView.layer.cornerRadius = 4;
    _borderView.backgroundColor = [UIColor clearColor];
    _borderView.center = CGPointMake(self.center.x, self.center.y-64);
}

- (void)show:(BOOL)isShow {
    
    if (isShow) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.04
                                                  target:self
                                                selector:@selector(animationAction)
                                                userInfo:nil
                                                 repeats:YES];
    }
}

- (void)hide:(BOOL)isHide {
    if (isHide) {
        [self.timer invalidate];
        self.timer = nil;
        [self removeFromSuperview];
    }
}

- (void)animationAction {
    
//    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
//    NSOperationQueue *mainQueue = [NSOperationQueue mainQueue];
//    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
//        NSLog(@"当前线程是 ---->%@",[NSThread currentThread]);
//        
//        _calculateIndex++;
//        if (_calculateIndex > 9) {
//            _calculateIndex = 0;
//            _index = _index % 3;
//            _index++;
//            switch (_index) {
//                case 1:
//                default:
//                    _FirstDotColor = _dotHighLightColor;
//                    _SecondDotColor = _dotNormalColor;
//                    _ThirdDotColor = _dotNormalColor;
//                    break;
//                    
//                case 2:
//                    _SecondDotColor = _dotHighLightColor;
//                    _FirstDotColor = _dotNormalColor;
//                    _ThirdDotColor = _dotNormalColor;
//                    break;
//                    
//                case 3:
//                    _ThirdDotColor = _dotHighLightColor;
//                    _SecondDotColor = _dotNormalColor;
//                    _FirstDotColor = _dotNormalColor;
//                    break;
//            }
//        }
//    }];
//    
//    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
//        _borderView.transform = CGAffineTransformRotate(_borderView.transform, _borderViewAngle);
//        [self setNeedsDisplay];
//    }];
//    
//    [op2 addDependency:op1];
//    [queue addOperation:op1];
//    [mainQueue addOperation:op2];
    
//    dispatch_group_async(_group_t, _queue_a, ^{
//        NSLog(@"当前线程是 ---->%@",[NSThread currentThread]);
//
//        _calculateIndex++;
//        if (_calculateIndex > 9) {
//            _calculateIndex = 0;
//            _index = _index % 3;
//            _index++;
//            switch (_index) {
//                case 1:
//                default:
//                    _FirstDotColor = _dotHighLightColor;
//                    _SecondDotColor = _dotNormalColor;
//                    _ThirdDotColor = _dotNormalColor;
//                    break;
//
//                case 2:
//                    _SecondDotColor = _dotHighLightColor;
//                    _FirstDotColor = _dotNormalColor;
//                    _ThirdDotColor = _dotNormalColor;
//                    break;
//
//                case 3:
//                    _ThirdDotColor = _dotHighLightColor;
//                    _SecondDotColor = _dotNormalColor;
//                    _FirstDotColor = _dotNormalColor;
//                    break;
//            }
//        }
//    });
    
//    dispatch_group_notify(_group_t, _queue_a, ^{
//        dispatch_async(dispatch_get_main_queue(), ^{
//            NSLog(@"UI线程是 ---->%@",[NSThread currentThread]);
//            _borderView.transform = CGAffineTransformRotate(_borderView.transform, _borderViewAngle);
//            [self setNeedsDisplay];
//        });
//    });
    
    dispatch_async(dispatch_get_main_queue(), ^{
        _calculateIndex++;
        if (_calculateIndex > 9) {
            _calculateIndex = 0;
            _index = _index % 3;
            _index++;
            switch (_index) {
                case 1:
                default:
                    _FirstDotColor = _dotHighLightColor;
                    _SecondDotColor = _dotNormalColor;
                    _ThirdDotColor = _dotNormalColor;
                    break;

                case 2:
                    _SecondDotColor = _dotHighLightColor;
                    _FirstDotColor = _dotNormalColor;
                    _ThirdDotColor = _dotNormalColor;
                    break;

                case 3:
                    _ThirdDotColor = _dotHighLightColor;
                    _SecondDotColor = _dotNormalColor;
                    _FirstDotColor = _dotNormalColor;
                    break;
            }
        }
        
//        NSLog(@"UI线程是 ---->%@",[NSThread currentThread]);
        _borderView.transform = CGAffineTransformRotate(_borderView.transform, _borderViewAngle);
        [self setNeedsDisplay];
    });
    
}

#pragma mark - --------------------属性设置-------------------

- (void)dealloc {
    NSLog(@"LoadingView_Type_One 已经销毁了");
}

@end

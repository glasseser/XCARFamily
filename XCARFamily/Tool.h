//
//  Tool.h
//  car_video
//
//  Created by custom on 16/12/9.
//  Copyright © 2016年 self. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@class AFHTTPSessionManager;
@interface Tool : NSObject

+ (instancetype)shareTool;
- (id)copyWithZone:(NSZone *)zone;
+ (instancetype)allocWithZone:(struct _NSZone *)zone;


+ (UILabel *)labelWithTag:(NSInteger)tag toView:(UIView *)relayView font:(CGFloat)fontSize textColor:(UIColor *)textColor autoMaskContaint:(BOOL)isNeedAuto containt:(void (^)(NSDictionary *dict))containts;

+ (UIImageView *)imgViewWithTag:(NSInteger)tag toView:(UIView *)relayView placeImg:(UIImage *)placeImg autoMaskContaint:(BOOL)isNeedAuto containt:(void (^)(NSDictionary *dict))containts;

#pragma mark 根据颜色、大小生成一张图片
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
- (UIImage *)getImageBy:(UIView *)View;
+ (id)NSClassFromString:(NSString *)className;

#pragma mark - 根据标题获取相应的控制器的类名
+ (NSString *)ViewControllerNameWith:(NSString *)title;

#pragma mark - 网络请求
+ (void)Post:(NSString *)url
  Parameters:(NSDictionary *)parameters
     Setting:(void (^)(AFHTTPSessionManager *manager))settings
     Success:(void (^)(NSURLSessionDataTask * task, id responseObject))successBlock
        Fail:(void (^)(NSURLSessionDataTask * task, NSError * error))failBlock;

+ (void)network:(NSString *)urlString finishedBlock:(void (^)(NSDictionary *dict))finishedBlock;




@end

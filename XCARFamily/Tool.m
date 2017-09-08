//
//  Tool.m
//  car_video
//
//  Created by custom on 16/12/9.
//  Copyright © 2016年 self. All rights reserved.
//

#import "Tool.h"
#import "AFNetworking.h"

@implementation Tool

+ (instancetype)shareTool
{
    static id instance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instance = [[self alloc]init];
    });
    return instance;
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
    });
    return instance;
}


+ (UILabel *)labelWithTag:(NSInteger)tag
                   toView:(UIView *)relayView
                     font:(CGFloat)fontSize
                textColor:(UIColor *)textColor
         autoMaskContaint:(BOOL)isNeedAuto
                 containt:(void (^)(NSDictionary *dict))containts
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    if (relayView){
        [relayView addSubview:label];
    }
    
    label.font = [UIFont systemFontOfSize:fontSize];
    label.textColor = textColor;
    label.tag = tag;
    
    if (!isNeedAuto){
        label.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    //if (containts){
        //containts(nil);
    //}
    return label;
}

+ (UIImageView *)imgViewWithTag:(NSInteger)tag
                         toView:(UIView *)relayView
                       placeImg:(UIImage *)placeImg
               autoMaskContaint:(BOOL)isNeedAuto
                       containt:(void (^)(NSDictionary *dict))containts
{
    UIImageView *imgView = [[UIImageView alloc] initWithImage:placeImg];
    
    if (relayView){
        [relayView addSubview:imgView];
    }
    
    if (!isNeedAuto){
        imgView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    return imgView;
}

#pragma mark - 网络请求相关
+ (void)network:(NSString *)urlString finishedBlock:(void (^)(NSDictionary *))finishedBlock {
    //NSError *senderError = nil;
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.timeoutInterval = 10.0f;
    request.HTTPMethod = @"POST";
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error){
        if (!data){
            NSLog(@"没有数据返回");
            NSLog(@"error = %@",error);
            dispatch_sync(dispatch_get_main_queue(), ^{
                if (finishedBlock){
                    finishedBlock(@{@"errorMsg":@"timeOut"});
                }
            });
            return ;
        }
        
        if (error){
            NSLog(@"error!!! - %@",error);
            dispatch_sync(dispatch_get_main_queue(), ^{
                if (finishedBlock){
                    finishedBlock(@{@"errorMsg":error});
                }
            });
            return ;
        }
        
        NSError *otherError = nil;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&otherError];
        
        //NSLog(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        
       // NSLog(@"系统级别的解析方法 - dict = %@",dict);
        if (dict){
            dispatch_sync(dispatch_get_main_queue(), ^{
                if (finishedBlock){
                    finishedBlock(@{@"sourceData":dict});
                }
            });
        }
                                                }];
    
    [dataTask resume];
}

+ (void)Post:(NSString *)url
  Parameters:(NSDictionary *)parameters
     Setting:(void (^)(AFHTTPSessionManager *manager))settings
     Success:(void (^)(NSURLSessionDataTask * task, id responseObject))successBlock
        Fail:(void (^)(NSURLSessionDataTask * task, NSError * error))failBlock {
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
    manager.requestSerializer = [AFJSONRequestSerializer serializer]; //默认是解析成json格式类型
    manager.requestSerializer.timeoutInterval = 12;//设置12秒超时
    if (settings) {
        settings(manager);
    }
    
    if (parameters) {
        url = [NSString stringWithFormat:@"%@?",url];
        NSArray *keys = parameters.allKeys;
        NSArray *values = parameters.allValues;
        NSInteger count = keys.count;
        for (int i = 0;i< count;i++) {
            NSString *key = [keys objectAtIndex:i];
            id value = [values objectAtIndex:i];
            BOOL isEnd = (i==count-1);
            
            if ([value isKindOfClass:[NSString class]]) {
                url = [url stringByAppendingString:[NSString stringWithFormat:@"%@=\"%@\"",key,value]];
            }else{
                url = [url stringByAppendingString:[NSString stringWithFormat:@"%@=%@",key,value]];
            }
            if (!isEnd) {
                url = [url stringByAppendingString:[NSString stringWithFormat:@"&"]];
            }
        }
    }
    
    [manager POST:url
       parameters:parameters
         progress:nil
          success:successBlock
          failure:failBlock];
}

#pragma mark 根据颜色、大小生成一张图片
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark - 从view上截图
- (UIImage *)getImageBy:(UIView *)View
{
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(150, 150), NO, 1.0);  //NO，YES 控制是否透明
    [View.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    // 生成后的image
    
    return image;
}

+ (id)NSClassFromString:(NSString *)className
{
    Class aClass = NSClassFromString(className);
    BaseViewController *result = [[aClass alloc] init];
    return result;
}

#pragma mark - 根据标题获取相应的控制器的类名
+ (NSString *)ViewControllerNameWith:(NSString *)title {
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"CategoryVC" ofType:@"plist"];
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:filePath];
    NSString *vcName = [NSString stringWithFormat:@"%@_ViewController",[dict objectForKey:title]];
    NSLog(@"vcName = %@",vcName);
    return vcName;
}


@end

//
//  focusImg_Model.h
//  car_video
//
//  Created by custom on 16/12/17.
//  Copyright © 2016年 self. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface focusImg_Model : NSObject

/*
 JumpType = 0;
 fromtype = 0;
 id = 896881;
 imgurl = "http://www2.autoimg.cn/newsdfs/g4/M0C/CA/FA/640x320_0_autohomecar__wKgH2lhT-yeADCELAAbwPMB_IEk959.jpg";
 jumpurl = "";
 mediatype = 1;
 pageindex = 1;
 replycount = 0;
 title = "\U5e74\U8f7b\U65b0\U9009\U62e9 \U4e2d\U56fd\U54c1\U724c\U516b\U4e07\U5185\U989c\U503c\U63a8\U8350";
 type = "\U9009\U8f66\U5bfc\U8d2d";
 updatetime = 20161217073901;
 */

@property (nonatomic , assign) NSInteger JumpType;
@property (nonatomic , assign) NSInteger fromtype;
@property (nonatomic , assign) long long Id;
@property (nonatomic , strong) NSString *imgurl;
@property (nonatomic , strong) NSString *jumpurl;
@property (nonatomic , assign) NSInteger mediatype;
@property (nonatomic , assign) NSInteger pageindex;
@property (nonatomic , assign) long long replycount;
@property (nonatomic , copy) NSString *title;
@property (nonatomic , copy) NSString *type;
@property (nonatomic , copy) NSString *updatetime;

+ (NSArray *)properties;
+ (instancetype)carWithDict:(NSDictionary *)dic;

+ (NSMutableArray *)dataSourceWithDict:(NSDictionary *)dict key:(NSString *)keyString;





@end

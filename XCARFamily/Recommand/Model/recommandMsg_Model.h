//
//  recommandMsg_Model.h
//  car_video
//
//  Created by custom on 16/12/9.
//  Copyright © 2016年 self. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface recommandMsg_Model : NSObject

/*
 "id": 96666,
 "title": "标题文字",
 "mediatype": 3,
 "type": "到店实拍",
 "time": "2016-12-09",
 "indexdetail": "",
 "smallpic": "",//小图
 "replycount": 18941,
 
 "pagecount": 0,
 "jumppage": 1,
 "lasttime": "",
 "newstype": 0,
 "updatetime": "20161209114735",
 "coverimages": []
 */

@property (nonatomic , assign) NSInteger Id;
@property (nonatomic , strong) NSString *title;
@property (nonatomic , assign) NSInteger mediatype;
@property (nonatomic , strong) NSString *type;
@property (nonatomic , strong) NSString *time;
@property (nonatomic , strong) NSString *indexdetail;
@property (nonatomic , strong) NSString *smallpic;
@property (nonatomic , assign) long replycount;
@property (nonatomic , assign) NSInteger pagecount;
@property (nonatomic , assign) NSInteger jumppage;
@property (nonatomic , strong) NSString *lasttime;
@property (nonatomic , assign) NSInteger newstype;
@property (nonatomic , strong) NSString *updatetime;
@property (nonatomic , strong) NSArray *coverimages;

+ (NSArray *)properties;
+ (instancetype)carWithDict:(NSDictionary *)dic;

+ (NSMutableArray *)dataSourceWithDict:(NSDictionary *)dict key:(NSString *)keyString;

@end

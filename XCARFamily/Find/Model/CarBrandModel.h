//
//  CarBrandModel.h
//  car_video
//
//  Created by imac on 2017/8/28.
//  Copyright © 2017年 self. All rights reserved.
//

#import "CommonRuntime_Model.h"

/*
 {
 "icon": "http://img2.xcarimg.com/PicLib/logo/pl56_160s.png?t=20170828",
 "id": 56,
 "name": "阿斯顿·马丁"
 }
 */

@interface CarBrandModel : CommonRuntime_Model

@property (nonatomic , strong) NSString *icon;
@property (nonatomic , assign) long id;
@property (nonatomic , strong) NSString *name;

@end

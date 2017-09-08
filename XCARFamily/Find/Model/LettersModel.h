//
//  LettersModel.h
//  car_video
//
//  Created by imac on 2017/8/28.
//  Copyright © 2017年 self. All rights reserved.
//

#import "CommonRuntime_Model.h"

/*
 "brandNum": 5,
 "letter": "a",
 "brands": [
 {
 "icon": "http://img3.xcarimg.com/PicLib/logo/pl1_160s.png?t=20170828",
 "id": 1,
 "name": "奥迪"
 }]
 */

@interface LettersModel : CommonRuntime_Model

@property (nonatomic , assign) long long brandNum;
@property (nonatomic , strong) NSString *letter;
@property (nonatomic , strong) NSArray *brands;

@end

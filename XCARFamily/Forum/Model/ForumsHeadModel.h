//
//  ForumsHeadModel.h
//  car_video
//
//  Created by imac on 2017/8/25.
//  Copyright © 2017年 self. All rights reserved.
//

#import "CommonRuntime_Model.h"

/*
 "focusId": 29412099,
 "focusLink": "http://a.xcar.com.cn/interface/6.0/bbs_detail.php?tid=29412099",
 "focusImage": "http://pic.xcarimg.com/img/news_photo/2017/03/20/0y7sw78VR41489972330153942148997233015.jpg",
 "focusTitle": "满足基本生活所需 版主述途观用车感受",
 "focusType": 1,
 "statisticsUrl": ""
 */

@interface ForumsHeadModel : CommonRuntime_Model

@property (nonatomic , assign) long long focusId;
@property (nonatomic , strong) NSString *focusLink;
@property (nonatomic , strong) NSString *focusImage;
@property (nonatomic , strong) NSString *focusTitle;
@property (nonatomic , assign) NSInteger focusType;
@property (nonatomic , strong) NSString *statisticsUrl;

@end

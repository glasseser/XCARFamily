//
//  ForumsModel.h
//  car_video
//
//  Created by imac on 2017/8/25.
//  Copyright © 2017年 self. All rights reserved.
//

#import "CommonRuntime_Model.h"

@interface ForumsModel : CommonRuntime_Model

@property (nonatomic , assign) long long postId;
@property (nonatomic , strong) NSString *postTitle;
@property (nonatomic , strong) NSString *postLink;
@property (nonatomic , strong) NSString *author;
@property (nonatomic , assign) long long createDate;
@property (nonatomic , strong) NSString *postImage;
@property (nonatomic , strong) NSString *forumName;
@property (nonatomic , assign) long replyCount;
@property (nonatomic , assign) long long replyDate;
@property (nonatomic , assign) NSInteger hasImage;
@property (nonatomic , assign) long viewCount;


/*
 {
 "postId": 30088027,
 "postTitle": "烈日炎炎为你而来 新蒙迪欧肌肉感十足",
 "postLink": "http://a.xcar.com.cn/interface/6.0/bbs_detail.php?tid=30088027",
 "author": "xuser11900951",
 "createDate": 1500965007,
 "postImage": "//image.xcar.com.cn/upc/2017/2017082414_90065de9f985676eba79MRHwYZSfW7U2_176x132.jpg",
 "forumName": "新蒙迪欧论坛",
 "replyCount": 11,
 "replyDate": 1503629125,
 "hasImage": 0,
 "viewCount": 25747
 },
 */

@end

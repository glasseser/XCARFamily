//
//  VideoInfoModel.h
//  CARFamily
//
//  Created by imac on 2017/9/1.
//  Copyright © 2017年 GuangZhouWeiControl. All rights reserved.
//

#import "CommonRuntime_Model.h"

/*
 {
 author = "<null>";
 categoryId = 4;
 categoryName = "\U65b0\U8f66\U89c6\U9891";
 commentCount = 1;
 "dely_date" = "2017-08-31 19:40:01";
 description = "";
 duration = 0;
 "get_vid" = "y_XMzAwMDIzMjA3Ng==";
 "image_url" = "http://vn.xcar.com.cn/xtv/qiniu/image/thumb/2017/08/31/o_1bos0tceh1dn91h08ke5lhch4en_s10_org.jpg?imageView2/1/w/448/h/252";
 mtitle = "\U672c\U7530HR-V\U5b89\U5168\U7684\U4fdd\U8bc1";
 num = 307;
 pdate = "2017-08-31 19:51:25";
 playCount = 307;
 poster = "xtv/qiniu/image/thumb/2017/08/31/o_1bos0tceh1dn91h08ke5lhch4en_s10_org.jpg";
 "poster_448x252" = "xtv/qiniu/image/thumb/2017/08/31/o_1bos0tceh1dn91h08ke5lhch4en_s10_org.jpg?imageView2/1/w/448/h/252";
 "qiniu_id" = 92400;
 source = "\U4f18\U9177";
 spic = "http://vn.xcar.com.cn/xtv/qiniu/image/thumb/2017/08/31/o_1bos0tceh1dn91h08ke5lhch4en_s10_org.jpg?imageView2/1/w/200/h/112";
 src = "http://vn.xcar.com.cn/xtv/qiniu/video/converted/mp4/2017/08/31/mp4_o_1bos0tceh1dn91h08ke5lhch4en_720p.mp4";
 state = 1;
 stitle = "\U672c\U7530HR-V\U5b89\U5168\U7684\U4fdd\U8bc1";
 suffix = m3u8;
 tag = "\U672c\U7530,HR-V";
 title = "\U672c\U7530HR-V\U5b89\U5168\U7684\U4fdd\U8bc1";
 "turn_duration" = "00:15";
 typeid = 4;
 "ugc_img" = "http://vn.xcar.com.cn/xtv/qiniu/image/thumb/2017/08/31/o_1bos0tceh1dn91h08ke5lhch4en_s10_org.jpg?imageView2/1/w/448/h/252";
 uploader = "\U738b\U5b50\U67ad";
 vid = 27662;
 webLink = "http://xtv.xcar.com.cn/show/201708/id_27662.html";
 "xtv_url" = "http://xtv.xcar.com.cn/show/201708/id_27662.html";
 "youku_url" = "http://v.youku.com/v_show/id_XMzAwMDIzMjA3Ng==.html";
 }
 */

@interface VideoInfoModel : CommonRuntime_Model

@property (nonatomic , strong) NSString *author;
@property (nonatomic , assign) NSInteger categoryId;
@property (nonatomic , strong) NSString *categoryName;
@property (nonatomic , assign) long commentCount;
@property (nonatomic , strong) NSString *dely_date;
@property (nonatomic , strong) NSString *Description;
@property (nonatomic , assign) long duration;
@property (nonatomic , strong) NSString *get_vid;
@property (nonatomic , strong) NSString *image_url;
@property (nonatomic , strong) NSString *mtitle;
@property (nonatomic , assign) long long num;
@property (nonatomic , strong) NSString *pdate;
@property (nonatomic , assign) long playCount;
@property (nonatomic , strong) NSString *poster;
@property (nonatomic , strong) NSString *poster_448x252;
@property (nonatomic , assign) long long qiniu_id;
@property (nonatomic , strong) NSString *source;
@property (nonatomic , strong) NSString *spic;
@property (nonatomic , strong) NSString *src;
@property (nonatomic , assign) BOOL state;
@property (nonatomic , strong) NSString *stitle;
@property (nonatomic , strong) NSString *suffix;
@property (nonatomic , strong) NSString *tag;
@property (nonatomic , strong) NSString *title;
@property (nonatomic , strong) NSString *turn_duration;
@property (nonatomic , assign) NSInteger typeid;
@property (nonatomic , strong) NSString *ugc_img;
@property (nonatomic , strong) NSString *uploader;
@property (nonatomic , assign) long long vid;
@property (nonatomic , strong) NSString *webLink;
@property (nonatomic , strong) NSString *xtv_url;
@property (nonatomic , strong) NSString *youku_url;




@end

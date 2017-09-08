//
//  NewsListView.h
//  CARFamily
//
//  Created by imac on 2017/9/1.
//  Copyright © 2017年 GuangZhouWeiControl. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NewsListView;
@protocol NewsListViewDelegate <NSObject>
@optional
- (void)NewsListView:(NewsListView *)listView
       didSelectItem:(NSInteger)index
               title:(NSString *)title;

@end

@interface NewsListView : UIView
@property (nonatomic , weak) id delegate;

@end

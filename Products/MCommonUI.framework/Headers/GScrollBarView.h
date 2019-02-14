//
//  GScrollBarView.h
//  GScrollBarDemo
//
//  Created by Caoguo on 2018/4/19.
//  Copyright © 2018年 Caoguo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GScrollBarView;

@protocol GScrollBarViewDelegat <NSObject>

- (void)scrollBarView: (GScrollBarView *)scrollBarView
         itemImgeView: (UIImageView *)itemImageView
                index:(NSInteger )index;

@end

@interface GScrollBarView : UIView

@property (nonatomic, strong) NSArray   *contents;            // 标题数组
@property (nonatomic, strong) NSArray   *images;              // 本地图片数组
@property (nonatomic, assign) NSInteger spaceOfTimeBySecond;  // 滚动时间间隔(默认2秒)
@property (nonatomic, weak)   id <GScrollBarViewDelegat> delegate;

/* 开始自动滚动 */
- (void)startAutoScroll;

/* 停止自动滚动 */
- (void)stopAutoScroll;

@end




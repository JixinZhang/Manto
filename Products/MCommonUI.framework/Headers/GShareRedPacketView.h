//
//  GShareRedPacketView.h
//  MCommonUI
//
//  Created by Namegold on 2017/8/21.
//  Copyright © 2017年 WSCN. All rights reserved.
//

#import <UIKit/UIKit.h>

//typedef void(^ShareBlock)(void);

@interface GShareRedPacketView : UIView

@property (nonatomic) CGPoint beginpoint;

@property (nonatomic, copy) void(^shareBlock)(void);
@property (nonatomic, assign) BOOL     shouldEnableTapSpread; // 是否支持点击展开
@property (nonatomic, assign) BOOL     alwaysSpread;          // 是否允许一直展开
@property (nonatomic)         CGFloat  minFrameY;             // 向上拖动最小坐标Y值(默认不能超过导航栏)
@property (nonatomic)         CGFloat  maxFrameY;             // 向下拖动最大坐标Y值(默认不能超出屏幕最下方)

///**
// 分享得红包view
//
// @return 分享view
// */
//+ (GShareRedPacketView *)sharedView;


/**
 显示分享view,并展示相应的文案

 @param string 文案
 */
- (void)displayWithTitleString: (NSString *)string;


/**
 设置是否收起

 @param shrink 是否收起
 */
- (void)setShrink: (BOOL)shrink;

//
///**
// 移除分享view
// */
//- (void)close;

@end

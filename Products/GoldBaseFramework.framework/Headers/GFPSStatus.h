//
//  GFPSStatus.h
//  WSCN
//
//  Created by Namegold on 2017/6/26.
//  Copyright © 2017年 jgCho. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface GFPSStatus : NSObject

+ (GFPSStatus *)sharedInstance;

/**
 显示页面FPS值
 */
- (void)open;


/**
 打开之后的block回调

 @param handler block回调
 */
- (void)openWithHandler:(void (^)(NSInteger fpsValue))handler;


/**
 不显示页面FPS值
 */
- (void)close;

@end

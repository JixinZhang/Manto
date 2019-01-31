//
//  GoldHybridWebView.h
//  GoldWebViewFramework
//
//  Created by Micker on 16/9/8.
//  Copyright © 2016年 wallstreetcn. All rights reserved.
//

#import <GoldWebViewFramework/GoldWebViewFramework.h>
@class HybridJsBridge;
/*!
 *	auto inject hybrid function
 */
@interface GoldHybridWebView : GoldWebView
@property (nonatomic, copy) NSString *bridgeName;
@property (nonatomic, strong, readonly) HybridJsBridge * bridge;

@end

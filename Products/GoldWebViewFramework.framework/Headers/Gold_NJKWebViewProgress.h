//
//  Gold_NJKWebViewProgress.h
//
//  Created by Satoshi Aasano on 4/20/13.
//  Copyright (c) 2013 Satoshi Asano. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#undef njk_weak
#if __has_feature(objc_arc_weak)
#define njk_weak weak
#else
#define njk_weak unsafe_unretained
#endif

extern const float Gold_NJKInitialProgressValue;
extern const float Gold_NJKInteractiveProgressValue;
extern const float Gold_NJKFinalProgressValue;

typedef void (^Gold_NJKWebViewProgressBlock)(float progress);
@protocol Gold_NJKWebViewProgressDelegate;
@interface Gold_NJKWebViewProgress : NSObject<UIWebViewDelegate>
@property (nonatomic, njk_weak) id<Gold_NJKWebViewProgressDelegate>progressDelegate;
@property (nonatomic, njk_weak) id<UIWebViewDelegate>webViewProxyDelegate;
@property (nonatomic, copy) Gold_NJKWebViewProgressBlock progressBlock;
@property (nonatomic, readonly) float progress; // 0.0..1.0

- (void)reset;
@end

@protocol Gold_NJKWebViewProgressDelegate <NSObject>
- (void)webViewProgress:(Gold_NJKWebViewProgress *)webViewProgress updateProgress:(float)progress;
@end


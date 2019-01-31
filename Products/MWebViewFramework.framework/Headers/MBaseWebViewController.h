//
//  MBaseWebViewController.h
//  MNewsDetailFramework
//
//  Created by Micker on 16/9/18.
//  Copyright © 2016年 Micker. All rights reserved.
//

#import <GoldBaseFramework/GoldBaseFramework.h>
#import <GoldWebViewFramework/GoldWebViewFramework.h>

/**
 MBaseProcessPool继承于WKProcessPool
 sharedProcessPool
 */
@interface MBaseProcessPool : WKProcessPool

+ (instancetype)sharedProcessPool;

@end

@interface MBaseWebViewController : BaseViewController<GoldWebViewProtocol, WKUIDelegate>

@property (nonatomic, strong, readonly) GoldWebView *webView;
@property (nonatomic, strong, readonly) WKProcessPool *processPool;
@property (nonatomic, strong, readonly) UIToolbar   *toolBar;
@property (nonatomic, copy) NSURL *requestURL;

- (void) loadDefaultRequest;

- (void) reloadData;

- (void) loadwkWebViewCookieWithName: (NSString *)name value: (NSString *)value domain: (NSString *)domain expireTime: (NSDate *)expireDate;

- (IBAction)backAction:(id)sender;

- (CGFloat)webViewHeight;

- (void) fontSizeChanged:(NSNotification *) notification;

- (void)updateCurrentWebContentFont: (NSInteger )fontSize;

- (NSDictionary *)reqeustHeaderFieldDictionary;

@end

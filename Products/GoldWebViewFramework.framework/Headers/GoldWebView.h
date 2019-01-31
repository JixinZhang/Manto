//
//  GoldWebView.h
//  GoldWebViewFramework
//
//  Created by Micker on 16/6/6.
//  Copyright © 2016年 wallstreetcn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@class GoldWebView, JSContext;

NS_ASSUME_NONNULL_BEGIN
@protocol GoldWebViewProtocol <NSObject>

@optional
- (void)webViewDidStartLoad:(GoldWebView *)webView;
- (void)webViewDidFinishLoad:(GoldWebView *)webView;
- (void)webView:(GoldWebView *)webView didFailLoadWithError:(nullable NSError *)error;
- (BOOL)webView:(GoldWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;

- (NSURL *) allowingReadAccessURLForWebView:(GoldWebView *)webView;//available for load local file for wkWebView

@end


@interface GoldWebView : NSObject

@property(weak, nonatomic) id<GoldWebViewProtocol> delegate;

@property (nonatomic, weak, nullable) UIView  *webView;

@property (nonatomic, readonly, strong, nullable) UIWebView *uiWebView;

@property (nonatomic, readonly, strong, nullable) WKWebView *wkWebView;

@property (nullable, nonatomic, readonly, strong) NSURLRequest *request;

@property (nonatomic, readonly, strong,nullable) UIScrollView *scrollView;

@property (nonatomic, readonly) BOOL canGoBack;

@property (nonatomic, readonly) BOOL canGoForward;

@property (nonatomic, readonly) double estimatedProgress;

@property (nonatomic, readonly) JSContext *jsContext;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) void (^progressBlock)(double progress);


- (instancetype)initWithFrame:(CGRect)frame configuration:(nullable WKWebViewConfiguration *)configuration;

- (void)loadRequest:(nonnull NSURLRequest *)request;

- (void)loadHTMLString:(nonnull NSString *)string baseURL:(nullable NSURL *)baseURL;

- (void)reload;

- (void)stopLoading;

- (void)goBack;

- (void)goForward;

- (void)evaluateJavaScript:(nonnull NSString *)javaScriptString completionHandler:(nullable void (^)(id, NSError *))completionHandler;


@end

NS_ASSUME_NONNULL_END


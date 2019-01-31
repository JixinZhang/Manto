//
//  MWebViewViewController.h
//  MNewsDetailFramework
//
//  Created by Micker on 16/9/13.
//  Copyright © 2016年 Micker. All rights reserved.
//

#import <GoldBaseFramework/GoldBaseFramework.h>
#import "MBaseWebViewController.h"

@interface MWebViewViewController : MBaseWebViewController

@property (nonatomic, strong, readonly) Gold_NJKWebViewProgressView *progressView;
@property (nonatomic, strong) UIImage *shareImage;

@property (nonatomic, assign, getter=isFullscreen) BOOL fullscreen;
@property (nonatomic, assign, getter=isStatusBarLight) BOOL statusBarLight;
@property (nonatomic, assign, getter=isHideShare) BOOL hideShare;
@property (nonatomic, copy) NSString *statusViewBgColor;

/**
 分享来自主题的第三方文章时，分享的content为
 
 Wechet : "本文来自主题XXX，点击查看更多精彩内容"
 Weibo : 【XXX主题】：文章标题 https://wallstreetcn.com/sdkfjdlskf
 */
@property (nonatomic, copy) NSString *shareContentWechat;
@property (nonatomic, copy) NSString *shareContentWeibo;
@property (nonatomic, copy) NSString *shareTitle;

/**
 分享来自主题的第三方文章时，分享的image
 */
@property (nonatomic, copy) NSString *shareImageURL;

@end


@interface MDefaultWebViewController : MWebViewViewController

- (BOOL)shouldEnableShare; // 是否支持分享

@end

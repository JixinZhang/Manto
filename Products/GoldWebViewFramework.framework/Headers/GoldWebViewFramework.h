//
//  GoldWebViewFramework.h
//  GoldWebViewFramework
//
//  Created by Micker on 16/6/6.
//  Copyright © 2016年 wallstreetcn. All rights reserved.
//

#import <UIKit/UIKit.h>

//! Project version number for GoldWebViewFramework.
FOUNDATION_EXPORT double GoldWebViewFrameworkVersionNumber;

//! Project version string for GoldWebViewFramework.
FOUNDATION_EXPORT const unsigned char GoldWebViewFrameworkVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <GoldWebViewFramework/PublicHeader.h>

#if __has_include(<GoldWebViewFramework/GoldWebViewFramework.h>)

#import <GoldWebViewFramework/GoldWebView.h>
#import <GoldWebViewFramework/GoldHybridWebView.h>
#import <GoldWebViewFramework/Gold_NJKWebViewProgress.h>
#import <GoldWebViewFramework/Gold_NJKWebViewProgressView.h>

#else

#import "GoldWebView.h"
#import "GoldHybridWebView.h"
#import "Gold_NJKWebViewProgress.h"
#import "Gold_NJKWebViewProgressView.h"

#endif


//
//  MWebViewFramework.h
//  MWebViewFramework
//
//  Created by Micker on 16/9/22.
//  Copyright © 2016年 Micker. All rights reserved.
//

#import <UIKit/UIKit.h>

//! Project version number for MWebViewFramework.
FOUNDATION_EXPORT double MWebViewFrameworkVersionNumber;

//! Project version string for MWebViewFramework.
FOUNDATION_EXPORT const unsigned char MWebViewFrameworkVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <MWebViewFramework/PublicHeader.h>

#if __has_include(<MWebViewFramework/MWebViewFramework.h>)

#import <MWebViewFramework/MBaseWebViewController.h>
#import <MWebViewFramework/MWebViewViewController.h>

#else

#import "MBaseWebViewController.h"
#import "MWebViewViewController.h"

#endif

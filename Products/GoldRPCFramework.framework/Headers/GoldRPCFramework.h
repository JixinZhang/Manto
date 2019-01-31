//
//  GoldRPCFramework.h
//  GoldRPCFramework
//
//  Created by Micker on 16/5/11.
//  Copyright © 2016年 wallstreetcn. All rights reserved.
//

#import <UIKit/UIKit.h>

//! Project version number for GoldRPCFramework.
FOUNDATION_EXPORT double GoldRPCFrameworkVersionNumber;

//! Project version string for GoldRPCFramework.
FOUNDATION_EXPORT const unsigned char GoldRPCFrameworkVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <GoldRPCFramework/PublicHeader.h>

#if __has_include(<GoldRPCFramework/GoldRPCFramework.h>)
#import <GoldRPCFramework/GoldBaseRequest.h>
#import <GoldRPCFramework/GoldRequest.h>
#import <GoldRPCFramework/GoldBatchRequest.h>
#import <GoldRPCFramework/GoldBaseReponse.h>
#import <GoldRPCFramework/GoldNetworkAgent.h>
#import <GoldRPCFramework/GoldNetworkConfig.h>
#import <GoldRPCFramework/GoldNetworkPrivate.h>
#import <GoldRPCFramework/NSDictionary+Response.h>
#import <GoldRPCFramework/GoldBaseRequest+Bussiness.h>
#import <GoldRPCFramework/GoldRequest+Bussiness.h>
#import <GoldRPCFramework/GoldBaseRequest+Error.h>
#import <GoldRPCFramework/GoldPageRequest.h>
#import <GoldRPCFramework/GoldCursorRequest.h>
#import <GoldRPCFramework/GoldCursorResponse.h>
#import <GoldRPCFramework/GoldRequestDownloader.h>
#import <GoldRPCFramework/GoldDownloadSessionManager.h>
#import <GoldRPCFramework/GoldContentLengthUtils.h>
#import <GoldRPCFramework/GoldTrafficMonitor.h>
#else
#import "GoldBaseRequest.h"
#import "GoldRequest.h"
#import "GoldBatchRequest.h"
#import "GoldBaseReponse.h"
#import "GoldNetworkAgent.h"
#import "GoldNetworkConfig.h"
#import "GoldNetworkPrivate.h"
#import "NSDictionary+Response.h"
#import "GoldBaseRequest+Bussiness.h"
#import "GoldRequest+Bussiness.h"
#import "GoldBaseRequest+Error.h"
#import "GoldPageRequest.h"
#import "GoldCursorRequest.h"
#import "GoldCursorResponse.h"
#import "GoldRequestDownloader.h"
#import "GoldDownloadSessionManager.h"
#import "GoldContentLengthUtils.h"
#import "GoldTrafficMonitor.h"
#endif

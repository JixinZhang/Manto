//
//  ZARPC.h
//  ZARPC
//
//  Created by AlexZhang on 2019/2/1.
//  Copyright © 2019 AlexZhang. All rights reserved.
//

#import <UIKit/UIKit.h>

//! Project version number for ZARPC.
FOUNDATION_EXPORT double ZARPCVersionNumber;

//! Project version string for ZARPC.
FOUNDATION_EXPORT const unsigned char ZARPCVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <ZARPC/PublicHeader.h>

#if __has_include(<ZARPC/ZARPC.h>)

// #import <ZARPC/PublicHeader.h>
#import <ZARPC/ZARPCBaseRequest.h>
#import <ZARPC/ZARPCBaseRequest+Error.h>
#import <ZARPC/ZARPCBaseRequest+Bussiness.h>
#import <ZARPC/ZARPCRequest.h>
#import <ZARPC/NSDictionary+Response.h>
#import <ZARPC/ZARPCNetworkPrivate.h>
#import <ZARPC/ZARPCNetworkConfig.h>
#import <ZARPC/ZARPCBaseResponse.h>
#import <ZARPC/ZARPCNetworkAgent.h>
#import <ZARPC/ZARPCContentLengthUtils.h>
#import <ZARPC/ZARPCTrafficMonitor.h>

#else

// #import "PublicHeader.h"
#import "ZARPCBaseRequest.h"
#import "ZARPCBaseRequest+Error.h"
#import "ZARPCBaseRequest+Bussiness.h"
#import "ZARPCRequest.h"
#imoprt "NSDictionary+Response.h"
#import "ZARPCNetworkPrivate.h"
#import "ZARPCNetworkConfig.h"
#import "ZARPCBaseResponse.h"
#import "ZARPCNetworkAgent.h"
#import "ZARPCContentLengthUtils.h"
#import "ZARPCTrafficMonitor.h"

#endif



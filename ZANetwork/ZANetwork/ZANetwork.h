//
//  ZANetwork.h
//  ZANetwork
//
//  Created by AlexZhang on 2019/2/1.
//  Copyright © 2019 AlexZhang. All rights reserved.
//

#import <UIKit/UIKit.h>

//! Project version number for ZANetwork.
FOUNDATION_EXPORT double ZANetworkVersionNumber;

//! Project version string for ZANetwork.
FOUNDATION_EXPORT const unsigned char ZANetworkVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <ZANetwork/PublicHeader.h>

#if __has_include(<ZANetwork/ZANetwork.h>)

// #import <ZANetwork/PublicHeader.h>

#import <ZANetwork/AFNetworking.h>
#import <ZANetwork/JSONKit.h>
#import <ZANetwork/OpenUDID.h>
#import <ZANetwork/UIImageView+WebCache.h>
#import <ZANetwork/UIButton+WebCache.h>
#import <ZANetwork/SDWebImageDownloader+NetStatus.h>
#import <ZANetwork/BWebSocket.h>
#import <ZANetwork/CocoaHTTPServer.h>
#import <ZANetwork/KTVHTTPCache.h>

#else

// #import "PublicHeader.h"

#import "AFNetworking.h"
#import "JSONKit.h"
#import "OpenUDID.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "SDWebImageDownloader+NetStatus.h"
#import "BWebSocket.h"
#import "CocoaHTTPServer.h"
#import "KTVHTTPCache.h"

#endif



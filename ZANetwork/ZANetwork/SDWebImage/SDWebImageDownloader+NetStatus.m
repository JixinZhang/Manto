//
//  SDWebImageDownloader+NetStatus.m
//  GoldNetworkFramework
//
//  Created by Micker on 2016/11/4.
//  Copyright © 2016年 wallstreetcn. All rights reserved.
//

#import "SDWebImageDownloader+NetStatus.h"

static BOOL wscn_isEnableDownloadImage = YES;

@implementation SDWebImageDownloader (NetStatus)

- (void) wscn_enableDownloadImage:(BOOL) flag {
    if (wscn_isEnableDownloadImage != flag) {
        wscn_isEnableDownloadImage = flag;
    }
}

- (BOOL) wscn_isEnableDownloadImage {
    return wscn_isEnableDownloadImage;
}

@end

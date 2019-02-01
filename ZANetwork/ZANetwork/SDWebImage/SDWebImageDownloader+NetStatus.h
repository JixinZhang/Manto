//
//  SDWebImageDownloader+NetStatus.h
//  GoldNetworkFramework
//
//  Created by Micker on 2016/11/4.
//  Copyright © 2016年 wallstreetcn. All rights reserved.
//

#import <GoldNetworkFramework/GoldNetworkFramework.h>

@interface SDWebImageDownloader (NetStatus)

- (void) wscn_enableDownloadImage:(BOOL) flag;

- (BOOL) wscn_isEnableDownloadImage;

@end

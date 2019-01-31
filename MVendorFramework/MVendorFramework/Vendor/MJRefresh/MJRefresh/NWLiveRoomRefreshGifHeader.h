//
//  NWLiveRoomRefreshGifHeader.h
//  News
//
//  Created by wscn on 16/4/14.
//  Copyright © 2016年 wallstreetcn. All rights reserved.
//

#import "MJRefresh.h"

@interface NWLiveRoomRefreshGifHeader : MJRefreshGifHeader

@property (nonatomic, assign) NSTimeInterval beginInterval;

- (void)removeMJRefreshTime;

@end

//
//  OffineEditProtocol.h
//  MCommonUI
//
//  Created by wscn on 2017/3/8.
//  Copyright © 2017年 WSCN. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol OffineEditProtocol <NSObject>

@required

- (void)offlineEditStart;

- (void)offlineEditEnd;

- (void)updateTopicEditStatus;


@end

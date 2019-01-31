//
//  BGStartApplicationHandler.h
//  MobileFramework
//
//  Created by micker on 15/5/15.
//  Copyright (c) 2015年 Micker.cn  All rights reserved.
//

@class BGMicroApplication;

@protocol BGStartApplicationHandler <NSObject>

@optional

- (BOOL) canHandleStartApplication:(BGMicroApplication *) application parames:(NSDictionary *) parames;


@end
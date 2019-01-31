//
//  BGMicroApplicationLaunchMode.h
//  MobileFramework
//
//  Created by micker on 15/5/14.
//  Copyright (c) 2015年 Micker.cn  All rights reserved.
//


typedef NS_ENUM (NSInteger, BGMicroApplicationLaunchMode) {
    BGMicroApplicationLaunchModeClearTop,
    BGMicroApplicationLaunchModePushWithAnimation,
    BGMicroApplicationLaunchModePushWithNoAnimation,
    BGMicroApplicationLaunchModePressentWithAnimation,
    BGMicroApplicationLaunchModePressentWithNoAnimation,
    BGMicroApplicationLaunchModeFlipFromLeft,
    BGMicroApplicationLaunchModeFlipFromRight,
};
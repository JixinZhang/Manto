//
//  BGClientDelegate.h
//  MobileFramework
//
//  Created by micker on 15/5/15.
//  Copyright (c) 2015年 Micker.cn  All rights reserved.
//

#import <UIKit/UIKit.h>

@class BGContext;

@interface BGClientDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic, strong) BGContext *context;

@property (nonatomic, strong) UIWindow *window;

+ (instancetype) sharedInstance;


@end

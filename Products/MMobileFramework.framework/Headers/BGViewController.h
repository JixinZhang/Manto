//
//  BGViewController.h
//  MobileFramework
//
//  Created by micker on 15/5/14.
//  Copyright (c) 2015年 Micker.cn  All rights reserved.
//

#import <UIKit/UIKit.h>

@class BGMicroApplication;

typedef NS_ENUM(NSUInteger, kViewAppearStateType)
{
    kViewAppearStateTypeNone = 0,
    kViewAppearStateTypeWillAppear,
    kViewAppearStateTypeDidAppear,
};

@interface BGViewController : UIViewController

@property (nonatomic, assign, readonly) BGMicroApplication *application;

@property (nonatomic, assign) BOOL isMiddlePage;

@property (nonatomic, assign) BOOL multiPage;

@property (nonatomic, strong) UIImage *preControllerImage;

@property (nonatomic, assign) kViewAppearStateType viewAppearState;

- (void) back;

- (void) callAsyncBlock:(void (^)(void)) block completion:(void(^)(void)) completion;

- (void) stopAllAsyncBlock;

- (NSString *) pageID;

- (void) viewWillDestory;

- (void) startTitleLoading;

- (void) stopTitleLoading;

+ (void) dismissAlertViews;

@end

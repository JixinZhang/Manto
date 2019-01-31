//
//  BasePresenter.h
//  GoldBaseFramework
//
//  Created by hushaohua on 11/9/16.
//  Copyright © 2016 wallstreetcn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol ViewPresenterProtocol <NSObject>

- (void) viewWillPresent;
- (void) viewDidPresent;
- (void) viewWillEndPresenting;
- (void) viewDidEndPresenting;

- (void) setContentView:(UIView *)view;

@end

@interface BaseViewPresenter : NSObject<ViewPresenterProtocol>

@property(nonatomic, weak) UIView* view;


@property(nonatomic, weak) BaseViewPresenter* parentViewPresenter;
- (void) addChildViewPresenter:(BaseViewPresenter *)viewPresenter;

- (void) performCommand:(id)command userInfo:(id)userInfo;

- (id) getContentsWithCommand:(id)command userInfo:(id)userInfo;

- (void)deviceRotateOrientationDidChange;

@end

@interface BaseViewPresenter(AutoAdjustFontSize)

/**
 Recevie UIContentSizeCategoryDidChangeNotification
 
 */
- (void) doAutoAdjustFontSize;

@end

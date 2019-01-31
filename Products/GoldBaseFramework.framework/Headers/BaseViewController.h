//
//  BaseViewController.h
//  GoldBase
//
//  Created by Micker on 16/5/4.
//  Copyright © 2016年 wallstreetcn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThemeManager.h"
#import "UIColor+Extend.h"

@protocol ViewControllerAppearanceDelegate <NSObject>

@optional
- (void) configApperanceForViewDidLoad:(UIViewController *)viewController;
- (void) configApperanceForViewWillAppear:(UIViewController *)viewController;
- (void) configApperanceForViewDidAppear:(UIViewController *)viewController;
- (void) configApperanceForViewWillDisappear:(UIViewController *)viewController;
- (void) configApperanceForViewDidDisappear:(UIViewController *)viewController;

- (CGRect) mainViewFrame:(UIViewController *)viewController;

@end

/*!
 *	This is the base viewController, every ViewController need to inherit it
 */
@interface BaseViewController : UIViewController{
}

@property(nonatomic, class, weak) id<ViewControllerAppearanceDelegate> classAppearanceDelegate;
@property(nonatomic, weak) id<ViewControllerAppearanceDelegate> instanceAppearanceDelegate;

@property(nonatomic, class, strong) UIColor* viewBackgroundColor;

/*!
 *	Show the custom left button while the viewcontroller's count is more than one
 */
- (void) showLeft;

/*!
 *	The custom left button 's action
 *
 *	@param sender	the button
 */
- (IBAction)actionBack:(id)sender;

/*!
 *	Theme changed function
 *
 *	@param type     the current theme type
 */
- (void) doUpdateTheme:(EThemeType) type;

/**
 Recevie UIContentSizeCategoryDidChangeNotification

 */
- (void) doAutoAdjustFontSize;

/*!
 *	Override this method to change the base view controller 's default config
    right now , 
    .backgroundColor = 14171A,
    .edgesForExtendedLayout = UIRectEdgeNone, 
    .automaticallyAdjustsScrollViewInsets = NO
 
 */
- (void) doViewDidLoad;

- (CGRect) mainViewFrame;

@end

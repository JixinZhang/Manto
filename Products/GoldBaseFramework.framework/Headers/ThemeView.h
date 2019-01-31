//
//  ThemeView.h
//  GoldThemeFramework
//
//  Created by Micker on 16/5/17.
//  Copyright © 2016年 wallstreetcn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThemeManager.h"

@interface ThemeView : UIView

@property (nonatomic, copy) void (^fontBlock)(void) ;
@property (nonatomic, copy) void (^themeBlock)(void) ;
@property (nonatomic, copy) void (^themeViewHideBlock)(void);

@property(nonatomic, strong) UIColor* highlightedColor;

@property(nonatomic, copy) NSString* cancelTitle;

- (void) hide;

- (void) hideAnimated:(BOOL)animated;

- (void) show;

- (void) showAnimated:(BOOL)animated;

@end

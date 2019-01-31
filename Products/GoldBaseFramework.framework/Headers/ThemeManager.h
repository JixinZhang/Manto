//
//  ThemeManager.h
//  GoldBase
//
//  Created by Micker on 16/5/4.
//  Copyright © 2016年 wallstreetcn. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString* const ThemeChangedNotification;

/*!
 *	@brief ETheme type
 */
typedef NS_ENUM(NSInteger, EThemeType) {
    /*!
     *	Day
     */
    EThemeTypeDay = 0,
    
    /*!
     *	Night
     */
    EThemeTypeNight,
    /*!
     *	Custom
     */
    EThemeTypeCustom,
    /*!
     *	Max, not used right now
     */
    EThemeTypeMax,
};

@protocol ThemeManager <NSObject>

- (void) doUpdateTheme:(EThemeType) type;

@end

@interface ThemeManager : NSObject<ThemeManager>

+ (instancetype) sharedInstance;

@property(nonatomic) BOOL themeEnabled;

- (void) doUpdateTheme:(EThemeType) type;

- (void) toggle;

- (EThemeType) currentTheme;

- (BOOL) isDay;

- (void) addThemeObserver:(NSObject *) observer withThemeChanged:(void (^)(EThemeType type))block;

@end

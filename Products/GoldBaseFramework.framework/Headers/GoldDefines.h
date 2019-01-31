//
//  GoldDefines.h
//  GoldBase
//
//  Created by Micker on 16/5/5.
//  Copyright © 2016年 wallstreetcn. All rights reserved.
//

#ifndef GoldDefines_h
#define GoldDefines_h

//static inline BOOL isIPhoneXSeries() {
//    BOOL iPhoneXSeries = NO;
//    if (UIDevice.currentDevice.userInterfaceIdiom != UIUserInterfaceIdiomPhone) {
//        return iPhoneXSeries;
//    }
//    
//    if (@available(iOS 11.0, *)) {
//        UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
//        if (mainWindow.safeAreaInsets.bottom > 0.0) {
//            iPhoneXSeries = YES;
//        }
//    }
//    
//    return iPhoneXSeries;
//}


#define KScreenSize         ([[UIScreen mainScreen] bounds].size)
#define KScreenWidth        ([[UIScreen mainScreen] bounds].size.width)
#define KScreenHeight       ([[UIScreen mainScreen] bounds].size.height)

/**
 判断是不是iPhone X
 */
//#define kDevice_IPhoneXSeries_S ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
//
//#define kDevice_IPhoneXSeriesR ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) : NO)
//
//#define kDevice_IPhoneXSeries_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) : NO)

//#define kDevice_IPhoneXSeries (isIPhoneXSeries())

#define kDevice_IPhoneXSeries (CGSizeEqualToSize(CGSizeMake(375.f, 812.f), [UIScreen mainScreen].bounds.size) || CGSizeEqualToSize(CGSizeMake(414, 896), [UIScreen mainScreen].bounds.size))
/**
 判断设备是否为iPad
 */
#define kDevice_Is_iPad [[[UIDevice currentDevice] model] isEqualToString:@"iPad"]


/**
 判断是否应该开启横竖屏切换
 */
#define kDevice_Is_EnableRotate ([[NSUserDefaults standardUserDefaults] boolForKey:@"enableScreenRotate"])

/**
 获取某个view安全区域

 @param view
 使用方法
 VIEWSAFEAREAINSETS(view).left
 VIEWSAFEAREAINSETS(self.view).right
 */
#define VIEWSAFEAREAINSETS(view) ({UIEdgeInsets i; if(@available(iOS 11.0, *)) {i = view.safeAreaInsets;} else {i = UIEdgeInsetsZero;} i;})


/**
 weakSelf
 strongSelf, 如使用(配合WEAK_SELF宏使用 || 定义弱引用变量名为`weakSelf`)
 */
#define WEAK_SELF(weakSelf) __weak __typeof(&*self) weakSelf = self;
#define STRONG_SELF(strongSelf) __strong __typeof(&*weakSelf) strongSelf = weakSelf;


#define KNavHeight          (kDevice_IPhoneXSeries ? 88.0 : 64.0)
#define KtabBarHeight       (kDevice_IPhoneXSeries? 83.0 : 49.0)
#define KStatusBarHeight    (kDevice_IPhoneXSeries ? 44.0 : 20.0)
#define KBottomMargin    (kDevice_IPhoneXSeries ? 34.0 : 0)

#endif /* GoldDefines_h */

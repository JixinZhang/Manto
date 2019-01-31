//
//  HXPhotoDefine.h
//  微博照片选择
//
//  Created by 洪欣 on 2017/11/24.
//  Copyright © 2017年 洪欣. All rights reserved.
//

#ifndef HXPhotoDefine_h
#define HXPhotoDefine_h

// 日志输出
#ifdef DEBUG
#define NSSLog(FORMAT, ...) fprintf(stderr,"%s:%d\t%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSSLog(...)
#endif

// 判断iPhone X
#define VendorDevice_IPhoneXSeries (CGSizeEqualToSize(CGSizeMake(375.f, 812.f), [UIScreen mainScreen].bounds.size) || CGSizeEqualToSize(CGSizeMake(414, 896), [UIScreen mainScreen].bounds.size))

// 导航栏 + 状态栏 的高度
#define kNavigationBarHeight (VendorDevice_IPhoneXSeries ? 88 : 64)
#define kTopMargin (VendorDevice_IPhoneXSeries ? 24 : 0)
#define kBottomMargin (VendorDevice_IPhoneXSeries ? 34 : 0)

#define iOS11_Later ([UIDevice currentDevice].systemVersion.floatValue >= 11.0f)

#define iOS9Later ([UIDevice currentDevice].systemVersion.floatValue >= 9.1f)

#define iOS9_Later ([UIDevice currentDevice].systemVersion.floatValue >= 9.0f)

#define iOS8_2Later ([UIDevice currentDevice].systemVersion.floatValue >= 8.2f)

#endif /* HXPhotoDefine_h */

//
//  UIFont+Extend.h
//  GoldBaseFramework
//
//  Created by Micker on 2017/5/10.
//  Copyright © 2017年 wallstreetcn. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 对systemFontOfSize，boldSystemFontOfSize中的部分字体进行了调整，
 如在iOS7.0以上，则对11，12，13，15，17号字体进行替换，对粗体的17亦能够进行监听；
 在iOS9.0以上，会增加16，20，22，28四个字号
 如果系统字体大小发生变化，需要处理通知“UIContentSizeCategoryDidChangeNotification”
 */
@interface UIFont (Extend)


/**
 是否开启跟随系统字体大小设置
 默认开启
 @param enable
 */
+ (void) shouldEnableAutoAdjustFontSize:(BOOL) enable;

+ (UIFont *)wscn_boldSystemFontOfSize:(CGFloat)fontSize;

+ (UIFont *)wscn_systemFontOfSize:(CGFloat)fontSize;

+ (BOOL)shouldEnableFontAutoSize;

+ (UIFont *) pingFangFontOfSize:(CGFloat)size weight:(CGFloat)weight;

@end

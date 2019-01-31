//
//  UIFont+AutoFontSize.h
//  GoldBaseFramework
//
//  Created by Micker on 2017/5/24.
//  Copyright © 2017年 wallstreetcn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (AutoFontSize)

+ (nullable UIFont *)autoSystemFontOfSize:(CGFloat)fontSize;
+ (nullable UIFont *)autoBoldSystemFontOfSize:(CGFloat)fontSize;
+ (nullable UIFont *)autoItalicSystemFontOfSize:(CGFloat)fontSize;
+ (nullable UIFont *)autoFontWithName:(NSString *_Nonnull)fontName size:(CGFloat)fontSize;
+ (nullable UIFont *)autoSystemFontOfSize:(CGFloat)fontSize weight:(CGFloat)weight;

@end

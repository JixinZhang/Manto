//
//  UIView+ANShape.h
//  tinker
//
//  Created by hushaohua on 15/5/7.
//  Copyright (c) 2015年 wallstreetcn. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ANViewBorderOrientation){
    ANViewBorderOrientationLeft   = 1 << 0,
    ANViewBorderOrientationBottom = 1 << 1,
    ANViewBorderOrientationRight  = 1 << 2,
    ANViewBorderOrientationTop    = 1 << 3
};

@interface UIView (ANShape)

- (void) setBorderColor:(UIColor *)color;

- (void) setBorderColor:(UIColor *)color width:(CGFloat)width;

- (void) setBorderOrientation:(NSInteger)orientationMask color:(UIColor *)color;

- (void) setBorderOrientation:(NSInteger)orientationMask color:(UIColor *)color borderWidth:(CGFloat)width;

- (void) circleWithBorderColor:(UIColor *)color width:(CGFloat)borderWidth;

- (void) circle;

- (void) roundCornerWithRadius:(CGFloat)radius;

- (void) roundCornerWithRadius:(CGFloat)radius color:(UIColor *)color;

- (void) clearRounder;

- (void) clearBorder;

+ (UIView *) singlelineViewWithHeight:(CGFloat)height;

+ (UIView *) singlelineViewWithWidth:(CGFloat)width;

@end

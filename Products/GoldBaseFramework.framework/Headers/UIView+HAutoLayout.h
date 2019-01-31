//
//  UIView+HAutoLayout.h
//  MNewsFramework
//
//  Created by hushaohua on 10/6/16.
//  Copyright © 2016 Micker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (HAutoLayout)

- (void) h_addConstraints:(NSArray *)constraints;

- (NSArray *) h_constraintsWithEdgeInsets:(UIEdgeInsets)edgeInsets;
- (NSArray *) h_constraintsWithFrame:(CGRect)frame;

- (NSArray *) h_constraintsWithTopEdgeInset:(CGFloat)topInset;
- (NSArray *) h_constraintsWithBottomEdgeInset:(CGFloat)topInset;
- (NSArray *) h_constraintsWithLeftEdgeInset:(CGFloat)topInset;
- (NSArray *) h_constraintsWithRightEdgeInset:(CGFloat)topInset;

- (NSArray *) h_constraintsWithTopEdgeInset:(CGFloat)topInset toView:(UIView *)view;
- (NSArray *) h_constraintsWithBottomEdgeInset:(CGFloat)topInset toView:(UIView *)view;
- (NSArray *) h_constraintsWithLeftEdgeInset:(CGFloat)topInset toView:(UIView *)view;
- (NSArray *) h_constraintsWithRightEdgeInset:(CGFloat)topInset toView:(UIView *)view;

- (NSArray *) h_constraintsWithOriginX:(CGFloat)originX;
- (NSArray *) h_constraintsWithOriginY:(CGFloat)originY;
- (NSArray *) h_constraintsWithWidth:(CGFloat)width;
- (NSArray *) h_constraintsWithHeight:(CGFloat)height;

- (NSArray *) h_constraintsWithOrigin:(CGPoint)point;
- (NSArray *) h_constraintsWithSize:(CGSize)size;

- (NSArray *) h_constraintsWithCenter;
- (NSArray *) h_constraintsWithCenterX;
- (NSArray *) h_constraintsWithCenterY;

//wating ....
//- (NSArray *) h_constraintsWithCenterToView:(UIView *)view;
//- (NSArray *) h_constraintsWithCenterXToView:(UIView *)view;
//- (NSArray *) h_constraintsWithCenterYToView:(UIView *)view;

- (NSArray *) h_constraintsWithAlignLeftToView:(UIView *)view;
- (NSArray *) h_constraintsWithAlignRightToView:(UIView *)view;
- (NSArray *) h_constraintsWithAlignBottomToView:(UIView *)view;
- (NSArray *) h_constraintsWithAlignTopToView:(UIView *)view;

@end

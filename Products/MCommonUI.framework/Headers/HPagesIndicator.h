//
//  HPageIndicator.h
//  HCarouselFramework
//
//  Created by hushaohua on 12/9/16.
//  Copyright © 2016 wallstreetcn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HPageIndicatorProtocol.h"

@interface HPagesIndicator : UIView<HPageIndicatorProtocol>

@property(nonatomic) UIEdgeInsets contentInsets;
@property(nonatomic) CGFloat dotSpace;
@property (nonatomic,assign)CGSize dotSize;
@property (nonatomic,assign)CGSize currentDotSize;
@property(nonatomic) UIControlContentHorizontalAlignment horizontalAlignment;

@property(nonatomic) BOOL rectDot;
@property(nonatomic) CGFloat dotCornerRadius;
@property(nonatomic) CGFloat currentDotCornerRadius;

@property(nullable, nonatomic,strong) UIColor *dotColor;
@property(nullable, nonatomic,strong) UIColor *currentDotColor;

- (void) updateIndicatorWithFactor:(CGFloat)factor;
- (void) updateIndicatorFrom:(NSInteger)fromIndex to:(NSInteger)toIndex deltaFactor:(CGFloat)deltaFactor;

@end

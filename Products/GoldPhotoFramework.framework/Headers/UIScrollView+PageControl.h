//
//  UIScrollView+PageControl.h
//  DW
//
//  Created by Micker on 15/7/3.
//  Copyright (c) 2015年 micker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (PageControl)

@property (nonatomic, strong, readonly) UIPageControl *pageControl;

- (void) showPageControl;

- (void) computePageControlPages;

@end

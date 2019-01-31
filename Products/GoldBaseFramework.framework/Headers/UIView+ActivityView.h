//
//  UIView+ActivityView.h
//  GoldTouTiao
//
//  Created by Micker on 16/5/19.
//  Copyright © 2016年 wallstreetcn. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIView (ActivityView)

/*!
 *	当前视图的状态指示器
 */
@property (nonatomic, strong, readonly) UIActivityIndicatorView *indicatorView;

@end

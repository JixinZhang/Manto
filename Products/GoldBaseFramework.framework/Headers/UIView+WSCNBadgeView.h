//
//  UIView+WSCNBadgeView.h
//  MHomeFramework
//
//  Created by AlexZhang on 2018/12/5.
//  Copyright © 2018 Micker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (WSCNBadgeView)

#pragma mark - wscnBadgeView
@property (nonatomic, strong) UILabel *wscnBadgeView;

/**
 UIView 右上角的Badge距离UIView.center的偏移量。
 horizontal 和 vertical 为正数则，向右下偏移
 */
@property (nonatomic, assign, setter=wscnSetBadgeViewOffset:, getter=wscnBadgeViewOffset) UIOffset wscnBadgeViewOffset;
@property (nonatomic, strong) NSLayoutConstraint *wscnBadgeViewWidthConstraint;

- (void)wscnShowBadgeViewWithBadgeValue:(NSString *)badgeValue;
- (void)wscnHideBadgeView;
- (BOOL)wscnIsBadgeViewShown;

#pragma mark - wscnNoticePointView

@property (nonatomic, strong) UIView *wscnNoticePointView;

/**
 UIView 右上角的小红点距离UIView.center的偏移量。
 horizontal 和 vertical 为正数则，向右下偏移
 */
@property (nonatomic, assign, setter=wscnSetNoticePointViewOffset:, getter=wscnNoticePointViewOffset) UIOffset wscnNoticePointViewOffset;

- (void)wscnShowNoticePointView;
- (void)wscnHideNoticePointView;
- (BOOL)wscnIsNoticePointViewShown;

@end

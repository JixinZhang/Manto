//
//  GRoofShadowNavigationView.h
//  MCommonUI
//
//  Created by Namegold on 2017/11/22.
//  Copyright © 2017年 WSCN. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BackButtonHandle)(void);

@interface GRoofShadowNavigationView : UIView

@property (nonatomic, copy)   void(^shareButtonHandle)(void);
@property (nonatomic, copy)   void(^backButtonHandle)(void);
@property (nonatomic, strong) UIButton         *shareButton;
@property (nonatomic, strong) UIButton         *rightButton;
@property (nonatomic, strong) UIButton         *backButton;
@property (nonatomic)         BOOL             emptyDataStatus;                // 空页面状态
@property (nonatomic)         BOOL             hiddenTitleView;                // 隐藏标题栏
@property (nonatomic)         BOOL             titleAlwaysShown;               // 标题总是展示
@property (nonatomic)         CGFloat          titleAwayLeftDistance;          // 标题居左距离
@property (nonatomic)         CGFloat          titleAwayRightDistance;         // 标题居右距离
@property (nonatomic)         CGFloat          beginEffectOffSetY;             // 渐变起始偏移量

- (void)setTitle: (NSString *)titleString;
- (void)setTitle: (NSString *)titleString titleColor: (UIColor *)color;
- (void)effectScrollWithOffsetY: (CGFloat )offsetY;

@end

//
//  BaseBottomView.h
//  GoldBaseFramework
//
//  Created by 朱义 on 2017/3/16.
//  Copyright © 2017年 wallstreetcn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseBottomView : UIView

- (instancetype)initWithFrame:(CGRect)frame hasShare:(BOOL)hasShareBtn;

@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) UIButton *shareBtn;
@property (nonatomic, assign) BOOL isHiddenNav;

@property (nonatomic, copy) void (^backClickBlock)();
@property (nonatomic, copy) void (^shareClickBlock)();

@end

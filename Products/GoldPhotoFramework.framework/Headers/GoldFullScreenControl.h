//
//  GoldFullScreenControl.h
//  B5MFullScreenFramework
//
//  Created by Micker on 15/8/20.
//  Copyright (c) 2015年 b5m. All rights reserved.
//

#include <UIKit/UIKit.h>
#import "UIScrollPageControlView.h"

@interface GoldFullScreenControl : NSObject<UIScrollPagePanGestureDelegate>

@property (nonatomic, strong) UIScrollPageControlView       *screenPageView;    //滚动视图

@property (nonatomic, assign) BOOL                           isAppear;

- (void) appearOnView:(UIView *) view;

- (void) disAppearOnView:(UIView *) view;

@end

//
//  YYLabel+ZYExtenion.h
//  MVendorFramework
//
//  Created by 朱义 on 2018/9/7.
//  Copyright © 2018年 Micker. All rights reserved.
//

#import <MVendorFramework/MVendorFramework.h>

@interface YYLabel (ZYExtenion)

@property (nonatomic, strong) UIColor *highlightBgColor;
@property (nonatomic, strong) UIColor *originBgColor;

- (void) showHighlightBg;
- (void) hiddenHighlightBg;

@end

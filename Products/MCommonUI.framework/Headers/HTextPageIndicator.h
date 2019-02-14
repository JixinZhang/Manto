//
//  HTextPageIndicator.h
//  MCommonUI
//
//  Created by hushaohua on 2017/5/3.
//  Copyright © 2017年 WSCN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HPageIndicatorProtocol.h"

@interface HTextPageIndicator : UIView<HPageIndicatorProtocol>

@property(nonatomic) NSTextAlignment alignment;

//not refresh texts
@property(nonatomic, strong) UIFont* textFont;
@property(nonatomic, strong) UIColor* textColor;

@property(nonatomic, strong) UIFont* separatorFont;
@property(nonatomic, strong) UIColor* separatorColor;

@property(nonatomic, strong) UIFont* currentTextFont;
@property(nonatomic, strong) UIColor* currentTextColor;

//refresh texts
//@property(nonatomic) NSInteger numberOfPages;
//@property(nonatomic) NSInteger currentPage;

@property(nonatomic) CGFloat textBaselineOffset;
@property(nonatomic) CGFloat currentTextBaselineOffset;
@property(nonatomic) CGFloat separatorBaselineOffset;

- (void) reloadData;


@end

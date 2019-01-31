//
//  FontPicker.h
//  GoldBaseFramework
//
//  Created by hushaohua on 2017/5/12.
//  Copyright © 2017年 wallstreetcn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FontPicker : UIView

@property (nonatomic, copy) void (^fontBlock)(void) ;
@property (nonatomic, copy) void (^fontPickerHideBlock)(void);

@property(nonatomic, strong) UIColor* highlightedColor;

@end

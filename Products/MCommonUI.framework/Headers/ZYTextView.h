//
//  ZYTextView.h
//
//
//  Created by 朱义 on 14-12-11.
//  Copyright (c) 2014年 ZhuYi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYTextView : UITextView

@property (nonatomic,copy)NSString *placeholder;
@property (nonatomic,strong)UIColor *placeholderColor;

- (void)defineTextWithText:(NSString *)text;

@end

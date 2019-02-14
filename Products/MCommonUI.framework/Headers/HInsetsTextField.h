//
//  HInsetsTextField.h
//  MCommonUI
//
//  Created by hushaohua on 2017/6/12.
//  Copyright © 2017年 WSCN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HInsetsTextField : UITextField

@property(nonatomic) UIEdgeInsets borderInsets;
@property(nonatomic) UIEdgeInsets textInsets;
@property(nonatomic) UIEdgeInsets placeholderInsets;
@property(nonatomic) UIEdgeInsets editingInsets;
@property(nonatomic) CGRect clearButtonRect;
@property(nonatomic) CGRect leftViewRect;
@property(nonatomic) CGRect rightViewRect;

@end

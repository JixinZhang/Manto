//
//  HPHTextView.h
//  MCommonUI
//
//  Created by hushaohua on 2017/10/19.
//  Copyright © 2017年 WSCN. All rights reserved.
//

#import <UIKit/UIKit.h>

//place holder text view

@class HPHTextView;
@protocol HPHTextViewDelegate<NSObject>

@optional
- (void) textViewDidChange:(HPHTextView *)textView;
- (BOOL) textViewShouldBeginEditing:(HPHTextView *)textView;
- (void) textViewDidEndEditing:(HPHTextView *)textView;
- (void) textViewDidBeginEditing:(HPHTextView *)textView;
- (BOOL) textView:(HPHTextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;

@end

@interface HPHTextView : UIView

@property(nonatomic, weak) id<HPHTextViewDelegate> delegate;

@property(nonatomic, copy) NSString* text;
@property(nonatomic, strong) UIColor* textColor;

@property(nonatomic, strong) UIFont* font;

@property(nonatomic, copy) NSString* placeholder;
@property(nonatomic, strong) UIColor* placeholderColor;

@property(nonatomic) UIEdgeInsets textInsets;

- (void) resetCursorPosition;

@end

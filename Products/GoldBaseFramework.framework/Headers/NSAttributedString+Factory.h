//
//  NSAttributedString+HFactory.h
//  MNewsFramework
//
//  Created by hushaohua on 10/6/16.
//  Copyright © 2016 Micker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSAttributedString (Factory)

+ (NSAttributedString *) attributedStringWithString:(NSString *)string
                                     systemFontSize:(CGFloat)fontSize
                                              color:(UIColor*)color;

+ (NSAttributedString *) attributedStringWithString:(NSString *)string
                                               font:(UIFont *)font
                                              color:(UIColor*)color;

+ (NSAttributedString *) attributedStringWithString:(NSString *)string
                                               font:(UIFont *)font
                                              color:(UIColor*)color
                                          linespace:(CGFloat)linespace;

+ (NSAttributedString *) attributedStringWithString:(NSString *)string
                                               font:(UIFont *)font
                                              color:(UIColor*)color
                                         lineHeight:(CGFloat)lineHeight;

+ (NSMutableAttributedString *) mutableAttributedStringWithString:(NSString *)string
                                     systemFontSize:(CGFloat)fontSize
                                              color:(UIColor*)color;

+ (NSMutableAttributedString *) mutableAttributedStringWithString:(NSString *)string
                                               font:(UIFont *)font
                                              color:(UIColor*)color;

- (CGSize)sizeLabelToFitWithWidth:(CGFloat)width height:(CGFloat)height numberOfLines:(NSInteger)numberOfLines;

@end

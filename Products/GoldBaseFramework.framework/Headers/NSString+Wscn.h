//
//  NSString+Wscn.h
//  GoldBaseFramework
//
//  Created by Micker on 16/8/26.
//  Copyright © 2016年 wallstreetcn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Wscn)

- (CGSize) sizeForFont:(UIFont *)font size:(CGSize)constraintSize style:(NSMutableParagraphStyle *)style;
- (CGSize)sizeLabelToFitWithWidth:(CGFloat)width height:(CGFloat)height font:(UIFont *)font numberOfLines:(NSInteger)numberOfLines;

@end

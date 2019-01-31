//
//  NSAttributedString+StringSize.h
//  MVendorFramework
//
//  Created by wscn on 16/9/15.
//  Copyright © 2016年 Micker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYTextLayout.h"

@interface NSAttributedString (StringSize)

- (CGSize)sizeForConstraintSize:(CGSize)constraintSize numberOfRows:(NSUInteger)rows;

@end

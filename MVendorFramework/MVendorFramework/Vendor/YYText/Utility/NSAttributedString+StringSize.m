//
//  NSAttributedString+StringSize.m
//  MVendorFramework
//
//  Created by wscn on 16/9/15.
//  Copyright © 2016年 Micker. All rights reserved.
//

#import "NSAttributedString+StringSize.h"


@implementation NSAttributedString (StringSize)

- (CGSize)sizeForConstraintSize:(CGSize)constraintSize numberOfRows:(NSUInteger)rows {
    YYTextContainer *container = [YYTextContainer new];
    container.size = constraintSize;
    container.maximumNumberOfRows = rows;
    YYTextLayout *layout = [YYTextLayout layoutWithContainer:container text:self];
    return layout.textBoundingSize;
}

@end

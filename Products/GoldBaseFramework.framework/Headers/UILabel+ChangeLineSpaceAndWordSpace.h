//
//  UILabel+ChangeLineSpaceAndWordSpace.h
//  HPayablePostFramework
//
//  Created by Namegold on 2017/5/27.
//  Copyright © 2017年 wallstreetcn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (ChangeLineSpaceAndWordSpace)

/**
 *  改变行间距
 */
- (void)changeLineSpaceForWithSpace:(float)space alignment: (NSInteger )alignment;

/**
 *  改变字间距
 */
- (void)changeWordSpaceWithSpace:(float)space;

/**
 *  改变行间距和字间距
 */
- (void)changeSpacewithLineSpace:(float)lineSpace WordSpace:(float)wordSpace;

@end

//
//  ThemeManager+FontSize.h
//  GoldBaseFramework
//
//  Created by Micker on 16/5/17.
//  Copyright © 2016年 wallstreetcn. All rights reserved.
//

#import "ThemeManager.h"

@interface ThemeManager (FontSize)

- (NSString *) fontSize;

- (NSInteger) fontSizeLevel;

- (void) saveFontSizeLevel:(NSInteger) level;

@end

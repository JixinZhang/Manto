//
//  UITableViewCell+BackgroundColor.h
//  GoldBaseFramework
//
//  Created by hushaohua on 12/27/16.
//  Copyright © 2016 wallstreetcn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (BackgroundColor)

- (void) storeSubviewBackgroundColor;
- (void) storeBackgroundColorOfView:(UIView *)view;

- (void) restoreSubviewBackgroundColor;

@end

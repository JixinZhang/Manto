//
//  HConvexScrollDelegate.h
//  MNewsFramework
//
//  Created by hushaohua on 9/29/16.
//  Copyright © 2016 Micker. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HConvexScrollViewContainerDelegate <NSObject>

- (void) subScrollViewDidScrolled:(UIScrollView *)scrollView;
- (void) subScrollViewWillEndDragging:(UIScrollView *)scrollView;
- (void) subScrollViewWillBeginDragging:(UIScrollView *)scrollView;

@end

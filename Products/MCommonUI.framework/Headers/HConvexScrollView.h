//
//  HConvexScrollView.h
//  MyUIView
//
//  Created by hushaohua on 9/28/16.
//  Copyright © 2016 wallstreetcn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HConvexScrollDelegate.h"
 
//                                —————————
//                               ｜        ｜
//                               ｜        ｜
//                               ｜        ｜
//                               ｜        ｜
//      －－－－－ －－－－－－－－－－          －－－－－－－－－－－－－－－－
//      ｜          ｜            ｜        ｜            ｜            ｜
//      ｜          ｜            ｜        ｜            ｜            ｜
//      ｜          ｜            ｜        ｜            ｜            ｜
//      －－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－

@class HConvexScrollView;
@protocol HConvexScrollViewSubDelegate <NSObject>

- (void) convexScrollView:(HConvexScrollView *)scrollView decelerateToOffset:(CGFloat)offset;

@end

@interface HConvexScrollView : UIScrollView<HConvexScrollViewContainerDelegate>

@property(nonatomic) CGFloat maxTopOffset;

@property(nonatomic, weak) id<HConvexScrollViewSubDelegate> subScrollDelegate;

@end

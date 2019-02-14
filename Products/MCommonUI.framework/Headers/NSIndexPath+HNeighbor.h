//
//  NSIndexPath+HNeighbor.h
//  HCarouselFramework
//
//  Created by hushaohua on 10/21/16.
//  Copyright © 2016 wallstreetcn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSIndexPath (HNeighbor)

- (NSIndexPath *) nextItem;
- (NSIndexPath *) previousItem;

- (NSIndexPath *) nextSection;
- (NSIndexPath *) previousSection;

@end

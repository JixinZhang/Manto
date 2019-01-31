//
//  HPagesRequest.h
//  MNewsFramework
//
//  Created by hushaohua on 10/1/16.
//  Copyright © 2016 Micker. All rights reserved.
//

#import "GoldRequest.h"

@interface GoldPageRequest : GoldRequest

@property (nonatomic, assign) NSUInteger    page;
@property (nonatomic, assign) NSUInteger    pageSize;

- (BOOL) isFirstPage;

- (id) gotoFirstPage;
- (id) gotoNextPage;

- (void) revertPage;

- (NSString *) queryKeyForPage; //default page
- (NSString *) queryKeyForPageSize; //default limit

@end

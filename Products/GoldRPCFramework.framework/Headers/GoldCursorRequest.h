//
//  GoldCursorRequest.h
//  GoldRPCFramework
//
//  Created by hushaohua on 2/8/17.
//  Copyright © 2017 wallstreetcn. All rights reserved.
//

#import "GoldRequest.h"

@interface GoldCursorRequest : GoldRequest

@property(nonatomic, copy) NSString* cursor;

@property(nonatomic) NSUInteger limit;//default 30

@end

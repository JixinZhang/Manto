//
//  ZARPCBaseResponse.m
//  ZARPC
//
//  Created by AlexZhang on 2019/2/13.
//  Copyright © 2019 AlexZhang. All rights reserved.
//

#import "ZARPCBaseResponse.h"
#import "NSDictionary+Response.h"

@implementation ZARPCBaseResponse

- (void)encodeWithCoder:(nonnull NSCoder *)aCoder {
    
}

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (id)initWithContent:(id)content {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (id)initWithContent:(id)content retainRawContent:(BOOL)retainRawContent {
    self = [super init];
    if (self) {
        if (retainRawContent) {
            self.rawContent = content;
        }
    }
    return self;
}

- (void)appendContent:(id)content {
    
}

@end

#pragma makr -
#pragma mark - ZARPCErrorResponse

@implementation ZARPCErrorResponse

- (id)initWithContent:(id)content {
    NSDictionary *diction = content;
    NSArray *errors   = [diction arrayValueForKey:@"errors"];
    if ([errors isKindOfClass:[NSArray class]] && [errors.firstObject isKindOfClass:[NSDictionary class]]){
        self = [super initWithContent:content];
        if (self){
            NSDictionary* error = errors.firstObject;
            self.code             = [error integerValueForKey:@"code"];
            if (50008 == self.code || 50012 == self.code || 50014 == self.code) {
                self.message = @"";
                self.message_human = @"";
            } else {
                self.message          = [error stringValueForKey :@"message"];
                self.message_human    = [error stringValueForKey :@"message_human"];
            }
            
        }
        return self;
    }else{
        return nil;
    }
}

@end

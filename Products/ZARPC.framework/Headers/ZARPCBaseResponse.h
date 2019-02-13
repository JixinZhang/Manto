//
//  ZARPCBaseResponse.h
//  ZARPC
//
//  Created by AlexZhang on 2019/2/13.
//  Copyright © 2019 AlexZhang. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ZARPCBaseResponse : NSObject<NSCoding>

@property (nonatomic, strong) id rawContent;

- (id)initWithContent:(id)content;

- (void)appendContent:(id)content;

- (id)initWithContent:(id)content retainRawContent:(BOOL)retainRawContent;

@end


@interface ZARPCErrorResponse : ZARPCBaseResponse

@property (nonatomic, assign) NSInteger code;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSString *message_human;

@end

//
//  TTNewsListRequest.h
//  TTNews
//
//  Created by AlexZhang on 2019/2/14.
//  Copyright © 2019 AlexZhang. All rights reserved.
//

#import <ZARPC/ZARPC.h>

NS_ASSUME_NONNULL_BEGIN

@interface TTNewsListRequest : ZARPCBaseRequest

@property (nonatomic, copy) NSString *category;
//@property (nonatomic, copy) NSString *device_id;
//@property (nonatomic, copy) NSString *iid;
//@property (nonatomic, copy) NSString *device_platform;
//@property (nonatomic, copy) NSString *version_code;

@end

NS_ASSUME_NONNULL_END

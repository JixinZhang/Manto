//
//  ZARPCContentLengthUtils.h
//  ZARPC
//
//  Created by AlexZhang on 2019/2/13.
//  Copyright © 2019 AlexZhang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZARPCContentLengthUtils : NSObject

/**
 获取带单位的文件大小, 如: 10MB, 1GB, 50KB
 
 @param contentLength 文件长度
 @return 带单位的文件大小
 */
+ (NSString *)getUnitFormatedFileSizeWithContentLength:(long long)contentLength;

/**
 获取文件大小的单位: B, KB, MB, GB
 
 @param contentLength 文件长度
 @return 单位: B, KB, MB, GB
 */

+ (NSString *)getUnitWithContentLength:(long long)contentLength;

@end

NS_ASSUME_NONNULL_END

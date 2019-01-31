//
//  GoldContentLengthUtils.h
//  GoldRPCFramework
//
//  Created by AlexZhang on 2018/6/7.
//  Copyright © 2018 wallstreetcn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoldContentLengthUtils : NSObject

/**
 获取带单位的文件大小, 如: 10MB, 1GB, 50KB

 @param contentLength
 @return 带单位的文件大小
 */
+ (NSString *)getUnitFormatedFileSizeWithContentLength:(long long)contentLength;

/**
 获取文件大小的单位: B, KB, MB, GB

 @param contentLength
 @return 单位: B, KB, MB, GB
 */
+ (NSString *)getUnitWithContentLength:(long long)contentLength;

@end

//
//  ZARPCContentLengthUtils.m
//  ZARPC
//
//  Created by AlexZhang on 2019/2/13.
//  Copyright © 2019 AlexZhang. All rights reserved.
//

#import "ZARPCContentLengthUtils.h"

@implementation ZARPCContentLengthUtils

+ (NSString *)getUnitFormatedFileSizeWithContentLength:(long long)contentLength {
    NSString *fileSize = @"";
    NSString *unit = [self getUnitWithContentLength:contentLength];
    
    double fileSizeDouble = 0.0;
    
    if (contentLength >= 1024 * 1024 * 1024) {
        fileSizeDouble = (double)contentLength/1024.0/1024.0/1024.0;
    } else if (contentLength >= 1024 * 1024) {
        fileSizeDouble = (double)contentLength/1024.0/1024.0;
    } else if (contentLength >= 1024) {
        fileSizeDouble = (double)contentLength/1024.0;
    } else {
        fileSize = [NSString stringWithFormat:@"%lld %@",contentLength, unit];
        return fileSize;
    }
    
    fileSize = [NSString stringWithFormat:@"%.2f %@",fileSizeDouble, unit];
    return fileSize;
}

+ (NSString *)getUnitWithContentLength:(long long)contentLength {
    NSString *unit = @"B";
    if (contentLength >= 1024 * 1024 * 1024) {
        unit = @"GB";
    } else if (contentLength >= 1024 * 1024) {
        unit = @"MB";
    } else if (contentLength >= 1024) {
        unit = @"KB";
    } else {
        unit = @"B";
    }
    return unit;
}

@end

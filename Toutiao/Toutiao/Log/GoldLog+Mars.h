//
//  GoldLog+Mars.h
//  WSCN
//
//  Created by Micker on 2017/5/22.
//  Copyright © 2017年 jgCho. All rights reserved.
//

#import <GoldLogFramework/GoldLogFramework.h>

@interface GoldLog (Mars)

+(void)GoldLog:(GOLD_LOG_LEVEL_TYPE)level
          file:(const char*)sourceFile
    lineNumber:(int)lineNumber
          func:(const char *)funcName
        format:(NSString*)format,...;

+(void) startMarsLog;

+(void) endMarsLog;

@end

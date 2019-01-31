//
//  GoldLog+Mars.m
//  WSCN
//
//  Created by Micker on 2017/5/22.
//  Copyright © 2017年 jgCho. All rights reserved.
//

#import "GoldLog+Mars.h"

#import <sys/xattr.h>
#import <mars/xlog/xloggerbase.h>
#import <mars/xlog/xlogger.h>
#import <mars/xlog/appender.h>

@implementation GoldLog (Mars)

+(void)GoldLog:(GOLD_LOG_LEVEL_TYPE)level
          file:(const char*)sourceFile
    lineNumber:(int)lineNumber
          func:(const char *)funcName
        format:(NSString*)format,...
{
    if (level < [GoldLog getStartLevel]) {
        return;
    }

    TLogLevel logLevel = kLevelDebug;
    switch (level) {
        case GOLD_LOG_LEVEL_TYPE_DEBUG:
            logLevel = kLevelDebug;
            break;
        case GOLD_LOG_LEVEL_TYPE_INFO:
            logLevel = kLevelInfo;
            break;
        case GOLD_LOG_LEVEL_TYPE_WARN:
            logLevel = kLevelWarn;
            break;
        case GOLD_LOG_LEVEL_TYPE_ERROR:
            logLevel = kLevelError;
            break;
        case GOLD_LOG_LEVEL_TYPE_FATAL:
            logLevel = kLevelFatal;
            break;
            
        default:
            break;
    }
    XLoggerInfo info;
    info.level = logLevel;
    info.tag = "wscn";
    info.filename = sourceFile;
    info.func_name = funcName;
    info.line = lineNumber;
    gettimeofday(&info.timeval, NULL);
    info.tid = (uintptr_t)[NSThread currentThread];
    info.maintid = (uintptr_t)[NSThread mainThread];
    info.pid = 0;
    
    va_list argList;
    va_start(argList, format);
    NSString* message = [[NSString alloc] initWithFormat:format arguments:argList];
    xlogger_Write(&info, message.UTF8String);
    va_end(argList);
}

+(void)  startMarsLog {
    NSString* logPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingString:@"/log"];
    
    // set do not backup for logpath
    const char* attrName = "com.apple.MobileBackup";
    u_int8_t attrValue = 1;
    setxattr([logPath UTF8String], attrName, &attrValue, sizeof(attrValue), 0, 0);
    // init xlog
#if DEBUG
    xlogger_SetLevel(kLevelDebug);
    appender_set_console_log(true);
#else
    xlogger_SetLevel(kLevelError);
    appender_set_console_log(false);
#endif
    appender_open(kAppednerAsync, [logPath UTF8String], "wscn");
}

+(void) endMarsLog {
    appender_close();
}
@end

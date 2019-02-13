//
//  ZARPCRequest.m
//  ZARPC
//
//  Created by AlexZhang on 2019/2/1.
//  Copyright © 2019 AlexZhang. All rights reserved.
//

#import "ZARPCRequest.h"
#import "ZARPCNetworkPrivate.h"

@interface ZARPCRequest()

@property (nonatomic, strong) id cacheJson;

@end

@implementation ZARPCRequest {
    BOOL _dataFromCache;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.cacheType = ZARPCRequestCacheTypeRemoteOnly;
        self.cacheTimeInSeconds = 86400;
    }
    return self;
}

- (long long) cacheVersion {
    return 0;
}

- (id)cacheSensitiveData {
    return @"";
}

- (id)cacheFileNameFilterForRequestArgument:(id)argument {
    return argument;
}

- (void)checkDirectory:(NSString *)path {
    NSFileManager *fileManger = [NSFileManager defaultManager];
    BOOL isDir;
    if (![fileManger fileExistsAtPath:path isDirectory:&isDir]) {
        [self createBaseDirectoryAtPath:path];
    } else {
        if (!isDir) {
            NSError *error = nil;
            [fileManger removeItemAtPath:path error:&error];
            [self createBaseDirectoryAtPath:path];
        }
    }
}

- (void)createBaseDirectoryAtPath:(NSString *)path {
    __autoreleasing NSError *error = nil;
    [[NSFileManager defaultManager] createDirectoryAtPath:path
                              withIntermediateDirectories:YES
                                               attributes:nil
                                                    error:&error];
    if (error) {
        ERRLOG(@"create cache directory faile, error = %@", error);
    } else {
        
    }
}

+ (NSString *)cacheFolder {
    NSString *pathOfLibrary = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filePath = [pathOfLibrary stringByAppendingPathComponent:@"LazyRequestCache"];
    return filePath;
}

- (NSString *)cacheBasePath {
    NSString *path = [[self class] cacheFolder];
    [self checkDirectory:path];
    return path;
}

- (NSString *)cacheFileName {
    NSString *requestUrl = [self requestUrl];
    
    // 不使用cdnUrl的情况下,优先获取request对象的baseUrl,若获取不到则获取GoldNetworkConfig该单例的baseUrl
    NSString *baseUrl = [self baseUrl].length > 0 ? [self baseUrl] : @"";
    
    id argument = [self cacheFileNameFilterForRequestArgument:[self requestArgument]];
    NSString *requestInfo = [NSString stringWithFormat:@"ZARPC: Method: %@ URL:%@ Host:%@ argument:%@ AppVserion:%@ Sensitive:%@", @([self requestMethod]), requestUrl, baseUrl, argument? : @"", @"AppVersion", [self cacheSensitiveData]?:@""];
    NSString *cacheFileName = [ZARPCNetworkPrivate md5StringFromString:requestInfo];
    return cacheFileName;
}

- (NSString *)cacheFilePath {
    NSString *cacheFileName = [self cacheFileName];
    NSString *path = [self cacheBasePath];
    path = [path stringByAppendingPathComponent:cacheFileName];
    return path;
}

- (NSString *)cacheVersionFilePath {
    NSString *cacheVersionFileName = [NSString stringWithFormat:@"%@.ver", [self cacheFileName]];
    NSString *path = [self cacheBasePath];
    path = [path stringByAppendingPathComponent:cacheVersionFileName];
    return path;
}

- (long long)cacheVersionFileContent {
    NSString *path = [self cacheVersionFilePath];
    NSFileManager * fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path isDirectory:nil]) {
        NSNumber *version = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        return [version longLongValue];
    } else {
        return 0;
    }
}

- (int)cacheFileDuration:(NSString *)path {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    // get file attribute
    NSError *attributesRetrievalError = nil;
    NSDictionary *attributes = [fileManager attributesOfItemAtPath:path
                                                             error:&attributesRetrievalError];
    if (!attributes) {
        ERRLOG(@"Error get attributes for file at %@: %@", path, attributesRetrievalError);
        return -1;
    }
    int seconds = -[[attributes fileModificationDate] timeIntervalSinceNow];
    return seconds;
}

- (int) intervalAfterLastUpdate {
    NSString *path = [self cacheFilePath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:path isDirectory:nil]) {
        return -1;
    }
    
    return [self cacheFileDuration:path];
}

- (void)start {
    _cacheJson = nil;
    _dataFromCache = NO;
    if (ZARPCRequestCacheTypeRemoteOnly == self.cacheType) {
        [super start];
        return;
    }
    
    // check cache time
    if ([self cacheTimeInSeconds] < 0) {
        [super start];
        return;
    }
    
    // check cache version
    long long cacheVersionFileContent = [self cacheVersionFileContent];
    if (cacheVersionFileContent != [self cacheVersion]) {
        [super start];
        return;
    }
    
    // check cache existance
    NSString *path = [self cacheFilePath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:path isDirectory:nil]) {
        [super start];
        return;
    }
    
    // check cache time
    int seconds = [self cacheFileDuration:path];
    if (seconds < 0 || seconds > [self cacheTimeInSeconds]) {
        [super start];
        return;
    }
    
    // load cache
    _cacheJson = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    if (_cacheJson == nil) {
        [super start];
        return;
    }
    
    _dataFromCache = YES;
    [self requestCompleteFilter];
    DEBUGLOG(@"===数据来自缓存=== 【%@】", [self debugDescription]);
    
    if ([self checkBussinessSuccess]){
        if (self.successCompletionBlock) {
            self.successCompletionBlock(self);
        }
    }
    
    if (ZARPCRequestCacheTypeDiskAndRemote == self.cacheType) {
        _cacheJson = nil;
        _dataFromCache = NO;
        [super start];
    }
    else if (ZARPCRequestCacheTypeDiskOrRemote == self.cacheType) {
        ;//        [self clearCompletionBlock];
        
        if (![self checkBussinessSuccess] && self.failureCompletionBlock){
            self.failureCompletionBlock(self);
        }
        _cacheJson = nil;
    }else{
        _cacheJson = nil;
    }
}

- (void)startWithoutCache {
    [super start];
}

- (BOOL) loadDataFromCache {
    self.responseObject = [self cacheJson];
    if (self.responseObject && self.cacheCompletionBlock) {
        DEBUGLOG(@"===数据来自缓存,无有效性校验=== 【%@】", [self debugDescription]);
        self.cacheCompletionBlock(self);
        _cacheJson = nil;
        return YES;
    }
    return NO;
}

- (id)cacheJson {
    if (_cacheJson) {
        return _cacheJson;
    } else {
        NSString *path = [self cacheFilePath];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if ([fileManager fileExistsAtPath:path isDirectory:nil] == YES) {
            if (path.length > 0) {
                _cacheJson = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
            }
        }
        return _cacheJson;
    }
}

- (BOOL)isDataFromCache {
    return _dataFromCache;
}

- (BOOL)isCacheVersionExpired {
    // check cache version
    long long cacheVersionFileContent = [self cacheVersionFileContent];
    if (cacheVersionFileContent != [self cacheVersion]) {
        return YES;
    } else {
        return NO;
    }
}

- (id)responseObject {
    if (_cacheJson) {
        return _cacheJson;
    } else {
        return [super responseObject];
    }
}

#pragma mark - Network Request Delegate

- (void)requestCompleteFilter {
    [super requestCompleteFilter];
    [self saveJsonResponseToCacheFile:[super responseObject]];
}

// 手动将其他请求的JsonResponse写入该请求的缓存
// 比如AddNoteApi, UpdateNoteApi都会获得Note，且其与GetNoteApi共享缓存，可以通过这个接口写入GetNoteApi缓存
- (void)saveJsonResponseToCacheFile:(id)jsonResponse {
    if (ZARPCRequestCacheTypeRemoteOnly != self.cacheType &&
        [self cacheTimeInSeconds] > 0 &&
        ![self isDataFromCache]) {
        NSDictionary *json = jsonResponse;
        if (json != nil) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                
                [NSKeyedArchiver archiveRootObject:json toFile:[self cacheFilePath]];
                [NSKeyedArchiver archiveRootObject:@([self cacheVersion]) toFile:[self cacheVersionFilePath]];
                
            });
        }
    }
}

#pragma mark --Cache

- (void) clearCache {
    _dataFromCache = NO;
    _cacheJson = nil;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [fileManager removeItemAtPath:[self cacheFilePath] error:nil];
    });
}

+ (NSUInteger) getSize {
    __block NSUInteger size = 0;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *pathOfLibrary = [[self class] cacheFolder];
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSDirectoryEnumerator *fileEnumerator = [fileManager enumeratorAtPath:pathOfLibrary];
        for (NSString *fileName in fileEnumerator) {
            NSString *filePath = [pathOfLibrary stringByAppendingPathComponent:fileName];
            NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
            size += [attrs fileSize];
        }
    });
    return size;
}

+ (void) clearDisk {
    [self clearDiskOnCompletion:nil];
}

+ (void) clearDiskOnCompletion:(ZARPCRequestNoParamsBlock) completion {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *filePath = [[self class] cacheFolder];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [fileManager removeItemAtPath:filePath error:nil];
        [fileManager createDirectoryAtPath:filePath
               withIntermediateDirectories:YES
                                attributes:nil
                                     error:NULL];
        
        if (completion) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion();
            });
        }
    });
}

@end

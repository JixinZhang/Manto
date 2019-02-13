//
//  ZARPCBaseRequest.m
//  ZARPC
//
//  Created by AlexZhang on 2019/2/1.
//  Copyright © 2019 AlexZhang. All rights reserved.
//

#import "ZARPCBaseRequest.h"
#import "ZARPCNetworkAgent.h"

@implementation ZARPCBaseRequest

- (instancetype)init {
    self = [super init];
    if (self) {
        self.requestMethod = ZARPCRequestMethodGet;
        self.retryCountAfterFailure = 3;
    }
    return self;
}

- (NSString *)requestUrl {
    if (_requestUrl) {
        return _requestUrl;
    }
    return @"";
}

- (NSString *)baseUrl {
    return @"";
}

- (id)jsonValidator {
    return nil;
}

- (NSTimeInterval)requestTimeoutInterval {
    return 30;
}

- (NSSet *)responseAcceptableContentTypes {
    return [NSSet setWithObjects:@"application/json",@"text/json",@"text/html",@"image/gif", nil];
}

- (NSDictionary *)requestHeaderFieldValueDictionary {
    return nil;
}

- (NSURLRequest *)buildCustomUrlRequest {
    return nil;
}

- (BOOL)statusCodeVaildator {
    NSUInteger statusCode = [self responseStatusCode];
    return (statusCode >=200 && statusCode <= 299);
}

- (void)start {
    [self stop];
    [self reStart];
}

- (void)reStart {
    self.responseObject = nil;
    self.error = nil;
    [[ZARPCNetworkAgent sharedInstance] addRequest:self];
}

- (void)stop {
    [[ZARPCNetworkAgent sharedInstance] cancelRequest:self];
}

- (BOOL)isExecuting {
    return NSURLSessionTaskStateRunning == self.sessionDataTask.state;
}

- (void)setCompletionBlockWithSuccess:(void (^)(ZARPCBaseRequest *))success
                              failure:(void (^)(ZARPCBaseRequest *))failure {
    self.successCompletionBlock = success;
    self.failureCompletionBlock = failure;
}

- (void)startWithCompletionBlockWithSuccess:(void (^)(ZARPCBaseRequest *))success
                                    failure:(void (^)(ZARPCBaseRequest *))failure {
    [self setCompletionBlockWithSuccess:success failure:failure];
    [self start];
}

- (void)startWithCompletionBlockWithSuccess:(void (^)(ZARPCBaseRequest *))success
                                   progress:(void (^)(NSProgress *))progress
                                    failure:(void (^)(ZARPCBaseRequest *))failure {
    [self setCompletionBlockWithSuccess:success failure:failure];
    self.progressBlock = progress;
    [self start];
}

- (NSUInteger)responseStatusCode {
    return [(NSHTTPURLResponse *)self.sessionDataTask.response statusCode];
}

- (NSDictionary *)responseHeaders {
    return [(NSHTTPURLResponse *)self.sessionDataTask.response allHeaderFields];
}

- (AFConstructingBlock)constructingBodyBlock {
    return NULL;
}

- (NSString *)resumeableDownloadPath {
    return nil;
}

- (void)addAccessory:(id<ZARPCRequestAccessory>)accessory {
    if (!self.requestAccessories) {
        self.requestAccessories = [NSMutableArray array];
    }
    [self.requestAccessories addObject:accessory];
}

- (void)requestCompleteFilter {
    
}

- (NSString *)debugDescription {
    return [NSString stringWithFormat:@"class:%@, url:%@, httpMethod:%@", NSStringFromClass([self class]), [self requestUrl], @(self.requestMethod)];
}

@end

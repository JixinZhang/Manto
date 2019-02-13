//
//  ZARPCNetworkAgent.m
//  ZARPC
//
//  Created by AlexZhang on 2019/2/13.
//  Copyright © 2019 AlexZhang. All rights reserved.
//

#import "ZARPCNetworkAgent.h"
#import "ZARPCNetworkConfig.h"
#import "ZARPCBaseRequest.h"
#import "ZARPCNetworkPrivate.h"
#import "ZARPCBaseRequest+Bussiness.h"

@interface ZARPCNetworkAgent()

@property (nonatomic, strong) NSThread *thread;
@property (nonatomic, strong) AFHTTPSessionManager *manager;
@property (nonatomic, strong) ZARPCNetworkConfig *config;
@property (nonatomic, assign) BOOL logEnable;
@property (nonatomic, assign) NSUInteger retryIndex;


@end

@implementation ZARPCNetworkAgent

+ (ZARPCNetworkAgent *)sharedInstance {
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

+ (ZARPCNetworkAgent *)agentWithConfiguration:(NSURLSessionConfiguration *)configuration {
    ZARPCNetworkAgent *agent = [[ZARPCNetworkAgent alloc] initWithConfiguration:configuration];
    return agent;
}

- (instancetype)init {
    return [self initWithConfiguration:nil];
}

- (instancetype)initWithConfiguration:(NSURLSessionConfiguration *)configuration{
    self = [super init];
    if (self) {
        self.config = [ZARPCNetworkConfig sharedInstance];
        if (configuration == nil) {
            self.manager = [AFHTTPSessionManager manager];
        } else {
            self.manager = [[AFHTTPSessionManager alloc] initWithBaseURL:nil sessionConfiguration:configuration];
        }
        
        AFSecurityPolicy *security = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        [security setValidatesDomainName:NO];
        security.allowInvalidCertificates = YES;
        self.manager.securityPolicy = security;
        self.manager.operationQueue.maxConcurrentOperationCount = 4;
        self.logEnable = YES;
        [self.thread start];
    }
    return self;
}

- (NSThread *) thread{
    if (!_thread){
        _thread = [[NSThread alloc] initWithTarget:self selector:@selector(threadAction) object:nil];
    }
    return _thread;
}

- (void)enableLog:(BOOL)enable {
    _logEnable = enable;
}

#pragma mark -
#pragma mark - request

- (NSString *)buildRequestUrl:(ZARPCBaseRequest *)request {
    NSString *detailUrl = [request requestUrl];
    
    if ([detailUrl hasPrefix:@"http"]) {
        return detailUrl;
    }
    //
    NSArray *filters = [self.config urlFilters];
    for (id<B5MUrlFilterProtocol> f in filters) {
        detailUrl = [f filterUrl:detailUrl withRequest:request];
    }
    
    //优先获取request对象的baseURL，若获取不到则获取ZARPCNetworkConfig单例的baseURL
    NSString *baseUrl = [request baseUrl].length > 0 ? [request baseUrl] : [self.config baseUrl];
    
    return [NSString stringWithFormat:@"%@%@", baseUrl, detailUrl];
}

- (NSDictionary *)requestHeaderDictionary:(ZARPCBaseRequest *)request {
    NSDictionary *headerFieldValueDictionary = [request requestHeaderFieldValueDictionary];
    
    //增加ZARPCNetworkConfig中配置的headerFilters
    NSMutableDictionary *headerFiedldDictionary = [NSMutableDictionary dictionaryWithDictionary:headerFieldValueDictionary];
    NSArray *filters = [self.config headerFilters];
    for (id<ZARPCRequestHeaderProtocol> f in filters) {
        NSDictionary *headers = [f requestHeaderDictionary:headerFiedldDictionary withRequest:request];
        headerFiedldDictionary = [NSMutableDictionary dictionaryWithDictionary:headers];
    }
    return headerFiedldDictionary;
}

- (void)addHeaderDict:(NSDictionary *)headerFieldDictionary {
    if (headerFieldDictionary) {
        for (id key in headerFieldDictionary.allKeys) {
            if ([key isKindOfClass:[NSString class]] &&
                [headerFieldDictionary[key] isKindOfClass:[NSString class]]) {
                [self.manager.requestSerializer setValue:headerFieldDictionary[key] forHTTPHeaderField:key];
            } else {
                ERRLOG(@"Error, class of key/value in headerFieldValueDictionary should be NSString.");
            }
        }
    }
}

#pragma mark - Serializer

- (void)prepareSerializers:(ZARPCBaseRequest *)request {
    _manager.requestSerializer = request.requestSerializer?:[AFJSONRequestSerializer serializer];
    _manager.requestSerializer.timeoutInterval = request.requestTimeoutInterval;
    _manager.responseSerializer = request.responseSerializer?:[AFJSONResponseSerializer serializer];
    if ([request responseAcceptableContentTypes]) {
        [_manager.responseSerializer setAcceptableContentTypes:[request responseAcceptableContentTypes]];
    }
}

#pragma mark - Request

- (void)startRequest:(ZARPCBaseRequest *)request {
    ZARPCRequestMethod method = [request requestMethod];
    id param = request.requestArgument;
    
    __weak __typeof__ (self) weakSelf = self;
    switch (method) {
        case ZARPCRequestMethodGet:
        {
            request.sessionDataTask = [_manager GET:request.url
                                         parameters:param
                                           progress:NULL
                                            success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                request.responseObject = responseObject;
                                                [weakSelf handleRequestResult:request];
                                            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                request.error = error;
                                                [weakSelf handleRequestResult:request];
                                            }];
        }
            break;
        case ZARPCRequestMethodPost:
        {
            request.sessionDataTask = [_manager POST:request.url
                                          parameters:param
                                            progress:NULL
                                             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                 request.responseObject = responseObject;
                                                 [weakSelf handleRequestResult:request];
                                             } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                 request.error = error;
                                                 [weakSelf handleRequestResult:request];
                                             }];
        }
            break;
        case ZARPCRequestMethodPostForm:
        {
            request.sessionDataTask = [_manager POST:request.url
                                          parameters:param
                           constructingBodyWithBlock:[request constructingBodyBlock]
                                            progress:^(NSProgress * _Nonnull uploadProgress) {
                                                if (request.progressBlock) {
                                                    request.progressBlock(uploadProgress);
                                                }
                                            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                request.responseObject = responseObject;
                                                [weakSelf handleRequestResult:request];
                                            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                request.error = error;
                                                [weakSelf handleRequestResult:request];
                                            }];
        }
            break;
        case ZARPCRequestMethodHead:
        {
            request.sessionDataTask = [_manager HEAD:request.url
                                          parameters:param
                                             success:^(NSURLSessionDataTask * _Nonnull task) {
                                                 [weakSelf handleRequestResult:request];
                                             } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                 request.error = error;
                                                 [weakSelf handleRequestResult:request];
                                             }];
        }
            break;
        case ZARPCRequestMethodPut:
        {
            request.sessionDataTask = [_manager PUT:request.url
                                         parameters:param
                                            success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                [weakSelf handleRequestResult:request];
                                            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                request.error = error;
                                                [weakSelf handleRequestResult:request];
                                            }];
        }
            break;
        case ZARPCRequestMethodDelete:
        {
            request.sessionDataTask = [_manager DELETE:request.url
                                            parameters:param
                                               success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                   request.responseObject = responseObject;
                                                   [weakSelf handleRequestResult:request];
                                               } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                   request.error = error;
                                                   [weakSelf handleRequestResult:request];
                                               }];
        }
            break;
        case ZARPCRequestMethodPatch:
        {
            request.sessionDataTask = [_manager  PATCH:request.url
                                            parameters:param
                                               success: ^(NSURLSessionDataTask *task, id responseObject) {
                                                   request.responseObject = responseObject;
                                                   [weakSelf handleRequestResult:request];
                                               }
                                               failure: ^(NSURLSessionDataTask *task, NSError *error) {
                                                   request.error = error;
                                                   [weakSelf handleRequestResult:request];
                                               }];
        }
            break;
        default:
            ERRLOG(@"Error, unsupport request method!");
            break;
    }
}

- (void) threadAction{
    @autoreleasepool {
        [[NSRunLoop currentRunLoop] addPort:[NSPort port] forMode:NSDefaultRunLoopMode];
        [[NSRunLoop currentRunLoop] run];
    }
}

- (void)startRequestOnThread:(ZARPCBaseRequest *)request {
    NSString *url = [self buildRequestUrl:request];
    __weak __typeof__ (self)weakSelf = self;
    request.url = url;
    NSDictionary *header = [self requestHeaderDictionary:request];
    
    [weakSelf prepareSerializers:request];
    [weakSelf addHeaderDict:header];
    [weakSelf startRequest:request];
    DEBUGLOG(@"Start request-async:%@",NSStringFromClass([request class]));
}

- (void)addRequest:(ZARPCBaseRequest *)request {
    [self performSelector:@selector(startRequestOnThread:) onThread:self.thread withObject:request waitUntilDone:NO];
}

- (void)cancelRequest:(ZARPCBaseRequest *)request {
    [request.sessionDataTask cancel];
    request.sessionDataTask = nil;
    _retryIndex = 0;
}

- (void)cancelAllRequest {
    for (NSUInteger i = 0, total = [_manager.tasks count]; i < total; i++) {
        NSURLSessionTask *task = [_manager.tasks objectAtIndex:i];
        [task cancel];
    }
}

- (BOOL)checkResult:(ZARPCBaseRequest *)request {
    BOOL result = [request statusCodeVaildator];
    if (!result) {
        return result;
    }
    
    id vaildator = [request jsonValidator];
    if (vaildator) {
        id json = [request responseObject];
        result = [ZARPCNetworkPrivate checkJSON:json withValidator:vaildator];
    }
    return result;
}

/**
 0:退出
 1:重试
 2:不重试

 @param request ZARPCBaseRequest
 @return return value description
 */
- (NSInteger)checkFailedRequest:(ZARPCBaseRequest *)request {
    BOOL flag = YES;
    NSArray *filters = [self.config failedFilters];
    for (id<ZARPFailedResponseProtocol> f in filters) {
        flag = [f doWithFailedRequest:request];
        if (!flag) {
            [request toggleAccessoriesWillStopCallBack];
            [request toggleAccessoriesDidStopCallBack];
            _retryIndex = 0;
            return 0;
        }
    }
    return flag ? 1 : 2;
}

- (void)handleRequestResult:(ZARPCBaseRequest *)request {
    if (request.sessionDataTask.state != NSURLSessionTaskStateCanceling &&
        request.sessionDataTask.state != NSURLSessionTaskStateCompleted) {
        return;
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if ([self checkResult:request]) {
            
            if (!request.responseObject) {
                FATALLOG(@"响应体为空异常");
            }
            
            if ([request checkBussinessSuccess]) {
                DEBUGLOG(@"===请求体的成功回调===[%@]=== %@", [request debugDescription], self.logEnable ? request.responseObject : @"use enableLog to log response object");
                
                [request toggleAccessoriesWillStopCallBack];
                [request requestCompleteFilter];
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (request.delegate && [request.delegate respondsToSelector:@selector(requestDidSuccess:)]) {
                        [request.delegate requestDidSuccess:request];
                    }
                    
                    if (request.successCompletionBlock) {
                        request.successCompletionBlock(request);
                    }
                });
                [request toggleAccessoriesDidStopCallBack];
                
            } else {
                DEBUGLOG(@"===请求体的业务失败回调--Error Code:%@ ===【%@】=== %@", @(request.error.code), [request debugDescription], self.logEnable ? request.responseObject  : @"use enableLog to log response object");
                NSInteger flag = [self checkFailedRequest:request];
                if (flag == 0) {
                    return;
                }
                [request toggleAccessoriesWillStartCallBack];
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (request.delegate && [request.delegate respondsToSelector:@selector(requestDidFailed:)]) {
                        [request.delegate requestDidFailed:request];
                    }
                    
                    if (request.failureCompletionBlock) {
                        request.failureCompletionBlock(request);
                    }
                });
                [request toggleAccessoriesDidStopCallBack];
            }
            
        } else {
            DEBUGLOG(@"---请求体的失败回调---【%@】failed, Error Code = %@---%@", [request debugDescription], @(request.error.code), request.responseObject);
            NSInteger flag = [self checkFailedRequest:request];
            if (flag == 0) {
                return;
            }
            if (flag == 1 && request.retryCountAfterFailure > ++self.retryIndex) {
                INFOLOG(@"---正在进行第【%@】次重试---【%@】", @(self.retryIndex), [request debugDescription]);
                [request reStart];
                return;
            }
            
            [request toggleAccessoriesWillStopCallBack];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (request.delegate && [request.delegate respondsToSelector:@selector(requestDidFailed:)]) {
                    [request.delegate requestDidFailed:request];
                }
                
                if (request.failureCompletionBlock) {
                    request.failureCompletionBlock(request);
                }
            });
            [request toggleAccessoriesDidStopCallBack];
        }
        self.retryIndex = 0;
    });
}

@end

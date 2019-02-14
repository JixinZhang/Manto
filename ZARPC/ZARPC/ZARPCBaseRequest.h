//
//  ZARPCBaseRequest.h
//  ZARPC
//
//  Created by AlexZhang on 2019/2/1.
//  Copyright © 2019 AlexZhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ZANetwork/ZANetwork.h>

typedef NS_ENUM(NSUInteger, ZARPCRequestMethod) {
    ZARPCRequestMethodGet = 0,
    ZARPCRequestMethodPost,
    ZARPCRequestMethodPostForm,
    ZARPCRequestMethodHead,
    ZARPCRequestMethodPut,
    ZARPCRequestMethodDelete,
    ZARPCRequestMethodPatch
};

typedef void (^AFConstructingBlock)(id <AFMultipartFormData> formData);

@class ZARPCBaseRequest;

#pragma mark - ZARPCRequestDelegate

/**
 代理方法回调
 */
@protocol ZARPCRequestDelegate <NSObject>

@optional

- (void)requestDidSuccess:(ZARPCBaseRequest *)request;
- (void)requestDidFailed:(ZARPCBaseRequest *)request;

@end

#pragma mark - ZARPCRequestAccessory
/**
 请求状态回调
 */
@protocol ZARPCRequestAccessory <NSObject>

@optional
- (void)requestWillStart:(ZARPCBaseRequest *)request;
- (void)requestWillStop:(ZARPCBaseRequest *)request;
- (void)requestDidStop:(ZARPCBaseRequest *)request;

@end

#pragma mark - ZARPCRequestDelegate

@class AFHTTPREquestOperation;

@interface ZARPCBaseRequest : NSObject

@property (nonatomic, assign) NSInteger tag;

@property (nonatomic, strong) NSDictionary *userInfo;

@property (nonatomic, strong) NSURLSessionDataTask *sessionDataTask;

@property (nonatomic, strong) NSMutableArray *requestAccessories;

@property (nonatomic, copy) NSString *url;

/**
 若返回的URL为HTTP开头 则直接请求该链接
 */
@property (nonatomic, copy) NSString *requestUrl;

/**
 请求成功后返回的数据
 */
@property (nonatomic, strong) id responseObject;

@property (nonatomic, strong) NSError *error;

/**
 请求参数
 */
@property (nonatomic, strong) id requestArgument;

@property (nonatomic, assign) ZARPCRequestMethod requestMethod;

@property (nonatomic, copy) void (^successCompletionBlock)(ZARPCBaseRequest *request);

@property (nonatomic, copy) void (^failureCompletionBlock)(ZARPCBaseRequest *request);

@property (nonatomic, copy) void (^progressBlock)(NSProgress *uploadProgress);

/**
 失败后的重试次数，默认为三次
 */
@property (nonatomic, assign) NSInteger retryCountAfterFailure;

@property (nonatomic, weak) id<ZARPCRequestDelegate> delegate;

@property (nonatomic, strong) AFHTTPRequestSerializer <AFURLRequestSerialization> *requestSerializer;

@property (nonatomic, strong) AFHTTPResponseSerializer <AFURLResponseSerialization> *responseSerializer;


/**
 开始request 返回结果已Block的形式回调 内部以打破循环引用

 @param success 成功回调
 @param failure 失败会掉
 */
- (void)startWithCompletionBlockWithSuccess:(void (^)(ZARPCBaseRequest *request))success
                                    failure:(void (^)(ZARPCBaseRequest *request))failure;


- (void)startWithCompletionBlockWithSuccess:(void (^)(ZARPCBaseRequest *request))success
                                   progress:(void (^)(NSProgress *uploadProgress))progress
                                    failure:(void (^)(ZARPCBaseRequest *request))failure;

/**
 开始当前请求
 */
- (void)start;

/**
 开始当前请求，不会cancel
 */
- (void)reStart;

/**
 停止当前请求
 */
- (void)stop;

/**
 判断当前request是否正在执行
 */
- (BOOL)isExecuting;

/**
 请求的Base url

 @return Base URL
 */
- (NSString *)baseUrl;

/**
 请求超时时间，默认30s

 @return 以秒为单位
 */
- (NSTimeInterval)requestTimeoutInterval;

/**
 检查json是否合法的对象

 @return return value description
 */
- (id)jsonValidator;

/**
 若用AF自带解析，若接受数据与AF不符，则需要指定接受类型

 @return 包含执行接受类型的NSSet
 */
- (NSSet *)responseAcceptableContentTypes;

/**
 在HTTP头部添加自定义参数

 @return NSDictionary
 */
- (NSDictionary *)requestHeaderFieldValueDictionary;

/**
 构建自定义的URLRequest, 忽略其他一切自定义的request方法(requestUrl, requestArgument, requestMethod,  requestSerializerType, requestHeaderFieldValueDictionary)

 @return 自定义的NSURLRequest
 */
- (NSURLRequest *)buildCustomURLRequest;

/**
 用来检查status code是否正常

 @return return value description
 */
- (BOOL)statusCodeVaildator;

/**
 当需要断点续传时，指定断点续传的地址

 @return URL string
 */
- (NSString *)resumeableDownloadPath;

/**
 当POST的内容带有文本或者富文本时使用

 @return AFConstructingBlock
 */
- (AFConstructingBlock)constructingBodyBlock;

- (void)requestCompleteFilter;

@end


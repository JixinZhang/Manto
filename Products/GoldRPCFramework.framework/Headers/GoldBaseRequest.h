//
//  GoldBaseRequest.h
//  B5MRPCFramework
//
//  Created bymickeron 15/11/11.
//  Copyright © 2015年 Micker All rights reserved.
//

#import <Foundation/Foundation.h>
#ifdef WITHOUT_SD
#import <GoldNetworkWithoutSDFramework/GoldNetworkWithoutSDFramework.h>
#else
#import <GoldNetworkFramework/GoldNetworkFramework.h>
#endif

// 请求方式
typedef NS_ENUM(NSUInteger , GoldRequestMethod) {
    GoldRequestMethodGet = 0,
    GoldRequestMethodPost,
    GoldRequestMethodPostForm,
    GoldRequestMethodHead,
    GoldRequestMethodPut,
    GoldRequestMethodDelete,
    GoldRequestMethodPatch
};

typedef void (^AFConstructingBlock)(id <AFMultipartFormData> formData);
@class GoldBaseRequest;

//代理方式回调
@protocol GoldRequestDelegate <NSObject>
@optional
- (void)requestDidSuccess:(GoldBaseRequest *)request;
- (void)requestDidFailed:(GoldBaseRequest *)request;
@end

// 请求状态回调
@protocol GoldRequestAccessory <NSObject>
@optional
- (void)requestWillStart:(GoldBaseRequest *)request;
- (void)requestWillStop:(GoldBaseRequest *)request;
- (void)requestDidStop:(GoldBaseRequest *)request;
@end

@class AFHTTPRequestOperation;
@interface GoldBaseRequest : NSObject{

}

@property (nonatomic) NSInteger tag;

@property (nonatomic, strong) NSDictionary *userInfo;

@property (nonatomic, strong) NSURLSessionDataTask *sessionDataTask;

@property (nonatomic, strong) NSMutableArray *requestAccessories;

@property (nonatomic, copy) NSString *url;

@property (nonatomic, copy) NSString *requestUrl;                               // 若返回的URL为HTTP开头 则直接请求该链接

@property (nonatomic, strong) id responseObject;

@property (nonatomic, strong) NSError *error;

@property (nonatomic, strong) id requestArgument;                               //请求参数

@property (nonatomic, assign) GoldRequestMethod      requestMethod;              //默认get请求

@property (nonatomic, copy) void (^successCompletionBlock)(GoldBaseRequest *);

@property (nonatomic, copy) void (^failureCompletionBlock)(GoldBaseRequest *);

@property (nonatomic, copy) void (^progressBlock)(NSProgress *uploadProgress);

@property (nonatomic, assign) NSInteger retryCountAfterFailure;     //重试次数,默认为3次

@property (nonatomic, assign) id<GoldRequestDelegate> delegate;

@property (nonatomic, strong) AFHTTPRequestSerializer <AFURLRequestSerialization> * requestSerializer;

@property (nonatomic, strong) AFHTTPResponseSerializer <AFURLResponseSerialization> * responseSerializer;

// 开始request 返回结果以block的形式回调 内部已打破循环引用 调用者不需要担心循环引用
- (void)startWithCompletionBlockWithSuccess:(void (^) (GoldBaseRequest *request))success
                                    failure:(void (^) (GoldBaseRequest *request))failure;

// 开始request 返回结果以block的形式回调 内部已打破循环引用 调用者不需要担心循环引用
- (void)startWithCompletionBlockWithSuccess:(void (^) (GoldBaseRequest *request))success
                                   progress:(void (^) (NSProgress *uploadProgress))progress
                                    failure:(void (^) (GoldBaseRequest *request))failure;

// 开始当前的request
- (void)start;

//开始当前的request,但不会cancel
- (void)reStart;

// 停止当前的request
- (void)stop;

// 判断当前的request是否正在执行
- (BOOL)isExecuting;

// 请求的baseUrl
- (NSString *)baseUrl;

// 请求超时时间,默认30秒
- (NSTimeInterval)requestTimeoutInterval;

// 用来检查JSON是否合法的对象
- (id)jsonValidator;

// 若用AF自带解析,若接受数据与AF不符,则要指定接受类型
- (NSSet *)responseAcceptableContentTypes;

// 在HTTP头部添加自定义的参数
- (NSDictionary *)requestHeaderFieldValueDictionary;

// 构建自定义的URLRequest, 忽略其他一切自定义的request方法(requestUrl, requestArgument, requestMethod, requestSerializerType,requestHeaderFieldValueDictionary)
- (NSURLRequest *)buildCustomUrlRequest;

// 用来检查Status Code是否正常的方法
- (BOOL)statusCodeValidator;

// 当需要断点续传时,指定断点续传的地址
- (NSString *)resumeableDownloadPath;

// 当POST的内容带有文本或者富文本的时候使用
- (AFConstructingBlock)constructingBodyBlock;

// 断点续传进度的block
//- (AFDownloadProgressBlock)resumableDownloadProgressBlock;


/// for subclasses to overwrite
- (void)requestCompleteFilter;

// for replace ip with do
- (BOOL) replaceDomainWithIP;

@end

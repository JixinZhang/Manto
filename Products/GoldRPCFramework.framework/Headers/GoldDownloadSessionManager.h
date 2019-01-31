//
//  GoldDownloadSessionManager.h
//  GoldNetworkFramework
//
//  Created by Micker on 2017/6/27.
//  Copyright © 2017年 wallstreetcn. All rights reserved.
//

#import <Foundation/Foundation.h>
#ifdef WITHOUT_SD
#import <GoldNetworkWithoutSDFramework/GoldNetworkWithoutSDFramework.h>
#else
#import <GoldNetworkFramework/GoldNetworkFramework.h>
#endif

NS_ASSUME_NONNULL_BEGIN


#pragma mark --
#pragma mark NSHTTPURLResponse(GoldDownload)

@interface NSHTTPURLResponse(GoldDownload)

- (long long) contentLength;

@end

#pragma mark --
#pragma mark NSURLSessionTask(GoldDownload)

@interface NSURLSessionTask(GoldDownload)

- (void) wscnCancel;

@end


#pragma mark --
#pragma mark GoldDownloadSessionManager

@interface GoldDownloadSessionManager : NSObject

+ (instancetype)manager;


- (NSURLSessionDataTask *) dataWithRequstURL:(NSURLRequest *) requestURL
                              didReceiveData:(void (^)(NSURLResponse *response,NSData *data))receiveBlock
                            downloadProgress:(void (^)(NSProgress *downloadProgress)) downloadProgressBlock
                                 destination:(NSURL * (^)(NSURLRequest *requestURL))destination
                           completionHandler:(void (^)(NSURLResponse *response, id _Nullable responseObject,  NSError * _Nullable error))completionHandler;


- (NSURLSessionDownloadTask *) downloadWithRequestURL:(NSURLRequest *) requestURL
                                             progress:(void (^)(NSProgress *downloadProgress)) downloadProgressBlock
                                          destination:(NSURL * (^)(NSURL *targetPath, NSURLResponse *response))destination
                                    completionHandler:(void (^)(NSURLResponse *response, NSURL *filePath, NSError *error))completionHandler;

@end


NS_ASSUME_NONNULL_END

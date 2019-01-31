//
//  GoldRequestDownloader.h
//  GoldRPCFramework
//
//  Created by Namegold on 2017/6/26.
//  Copyright © 2017年 wallstreetcn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#ifdef WITHOUT_SD
#import <GoldNetworkWithoutSDFramework/GoldNetworkWithoutSDFramework.h>
#else
#import <GoldNetworkFramework/GoldNetworkFramework.h>
#endif

@interface GoldRequestDownloader : NSObject


/**
 下载文件

 @param url 要下载的文件的url
 @param savePath 文件下载路径(需要拼接文件名)
 @param success 下载成功的回调block
 @param failure 下载失败的回调block
 @param progress 下载进度block
 */
- (void)downloadResourceWithResourceUrl: (NSString *)url
                                  fileSavePath: (NSString *)savePath
                                   success:(void (^)())success
                                   failure:(void (^)(NSError *error))failure
                                  progress:(void (^)(CGFloat executeProgress))progress;

/* 暂停下载 */
- (void)pause;

/* 取消下载 */
- (void)cancel;

/* 恢复下载 */
- (void)resumeDownload;


@end

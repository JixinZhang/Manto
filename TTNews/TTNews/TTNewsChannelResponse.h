//
//  TTNewsChannelResponse.h
//  TTNews
//
//  Created by AlexZhang on 2019/2/14.
//  Copyright © 2019 AlexZhang. All rights reserved.
//

#import <ZARPC/ZARPC.h>

NS_ASSUME_NONNULL_BEGIN

@interface TTNewsChannelItem : ZARPCBaseResponse

@property (nonatomic, copy) NSString *iid;
@property (nonatomic, copy) NSString *category;
@property (nonatomic, copy) NSString *web_url;
@property (nonatomic, copy) NSString *flags;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *tip_new;
@property (nonatomic, copy) NSString *default_add;
@property (nonatomic, copy) NSString *concern_id;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *icon_url;

@property(nonatomic, strong) id<TTChannelViewPresenterProtocol> presenter;


@end

@interface TTNewsChannelResponse : ZARPCBaseResponse

@property (nonatomic, readonly) NSArray<TTNewsChannelItem *> *channelItems;

@property (nonatomic, strong) NSArray<NSString *> *channelTitles;

@end

NS_ASSUME_NONNULL_END

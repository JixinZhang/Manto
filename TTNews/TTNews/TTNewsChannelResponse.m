//
//  TTNewsChannelResponse.m
//  TTNews
//
//  Created by AlexZhang on 2019/2/14.
//  Copyright © 2019 AlexZhang. All rights reserved.
//

#import "TTNewsChannelResponse.h"

#pragma mark -
#pragma mark - TTNewsChannelItem

@implementation TTNewsChannelItem



@end

#pragma mark -
#pragma mark - TTNewsChannelResponse

@interface TTNewsChannelResponse()

@property (nonatomic, strong) NSArray<TTNewsChannelItem *> *channelArray;

@end

@implementation TTNewsChannelResponse

- (instancetype)initWithContent:(id)content {
    self = [super initWithContent:content];
    if (self) {
        NSArray *data = [content arrayValueForKey:@"data"];
        NSMutableArray *mutaArray = [NSMutableArray arrayWithCapacity:data.count];
        NSMutableArray *mutaTitleArray = [NSMutableArray arrayWithCapacity:data.count];
        for (NSDictionary *dict in data) {
            TTNewsChannelItem *item = [TTNewsChannelItem yy_modelWithDictionary:dict];
            if (item) {
                [mutaArray addObject:item];
                [mutaTitleArray addObject:item.name];
            }
            item.presenter = [[NSClassFromString(@"TTNewsListViewPresenter") alloc] init];
            item.presenter.channelUserInfo = dict;
        }
        
        self.channelArray = [mutaArray copy];
        self.channelTitles = [mutaTitleArray copy];
    }
    return self;
}

- (NSArray *)channelItems {
    return self.channelArray;
}

@end

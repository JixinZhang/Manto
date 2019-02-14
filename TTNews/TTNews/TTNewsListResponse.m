//
//  TTNewsListResponse.m
//  TTNews
//
//  Created by AlexZhang on 2019/2/14.
//  Copyright © 2019 AlexZhang. All rights reserved.
//

#import "TTNewsListResponse.h"

#pragma mark -
#pragma mark - TTNewsImageModel

@implementation TTNewsImageModel

@end

#pragma mark -
#pragma mark - TTNewsInfoModel

@implementation TTNewsInfoModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"image_list" : [TTNewsImageModel class]
             };
}

@end

#pragma mark -
#pragma mark - TTNewsSummaryModel

@implementation TTNewsSummaryModel

- (TTNewsInfoModel *)infoModel {
    if (!_infoModel) {
        NSData *data = [self.content dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        TTNewsInfoModel *model = [TTNewsInfoModel yy_modelWithDictionary:dict];
        _infoModel = model;
    }
    return _infoModel;
}

@end

#pragma mark -
#pragma mark - TTNewsListResponse

@implementation TTNewsListResponse

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"data" : [TTNewsSummaryModel class]
             };
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.data = [NSArray array];
    }
    return self;
}

- (void)appendContent:(NSDictionary *)content {
    NSArray<NSDictionary *> *data = [content arrayValueForKey:@"data"];
    NSMutableArray *mutaArray = [NSMutableArray arrayWithArray:self.data];
    [data enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        TTNewsSummaryModel *summaryModel = [TTNewsSummaryModel yy_modelWithDictionary:obj];
        if (summaryModel) {
            [mutaArray addObject:summaryModel];
        }
    }];
    self.data = [mutaArray copy];    
}

@end

//
//  TTNewsListResponse.h
//  TTNews
//
//  Created by AlexZhang on 2019/2/14.
//  Copyright © 2019 AlexZhang. All rights reserved.
//

#import <ZARPC/ZARPC.h>

@interface TTNewsImageModel : ZARPCBaseResponse

@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *width;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *height;

@end

@interface TTNewsInfoModel : ZARPCBaseResponse

@property (nonatomic, copy) NSString *abstract;
@property (nonatomic, copy) NSString *media_name;
@property (nonatomic, copy) NSString *display_url;
@property (nonatomic, assign) NSInteger read_count;
@property (nonatomic, strong) NSArray *image_list;
@property (nonatomic, strong) TTNewsImageModel *middle_image;

@property (nonatomic, copy) NSString *verified_content;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *keywords;
@property (nonatomic, assign) int cell_type;

@property (nonatomic, copy) NSString *article_url;


@end

@interface TTNewsSummaryModel : ZARPCBaseResponse

@property (nonatomic, copy) NSString *content;
@property (nonatomic, assign) int code;
@property (nonatomic, strong) TTNewsInfoModel *infoModel;

@end

@interface TTNewsListResponse : ZARPCBaseResponse

@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSString *post_content_hint;
@property (nonatomic, assign) NSInteger total_number;
@property (nonatomic, strong) NSArray *data;

@end



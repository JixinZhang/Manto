//
//  YPhotosView.h
//  MCommonUI
//
//  Created by 朱义 on 2018/3/13.
//  Copyright © 2018年 WSCN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YPhotoModel.h"

@protocol YPhotosViewDelegate <NSObject>

- (void)clickPhotoWithImageUrl:(NSString *)imageUrl imageUrlArray:(NSArray *)imageUrlArray;
- (void)downloadImageWithImageView:(UIImageView *)imageView imageUrl:(NSString *)imageUrl;

@end

@interface YPhotosView : UIView

@property (nonatomic, weak) id <YPhotosViewDelegate> delegate;
@property (nonatomic, strong) YPhotoModel *photoModel;

//+ (CGFloat)imagesViewHeightWithPhotoModel:(YPhotoModel *)photoModel;

//+ (CGFloat)imagesViewHeightWithImageCount:(NSInteger)imageCount photosViewWidth:(CGFloat)photosViewWidth;

@end

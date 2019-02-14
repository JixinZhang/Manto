//
//  YPhotoModel.h
//  MCommonUI
//
//  Created by 朱义 on 2018/5/11.
//  Copyright © 2018年 WSCN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

typedef NS_ENUM(NSInteger, YPhotoViewType){
    YPhotoViewNineLattice,//9宫格显示
    YPhotoViewMaxRowCount,//每行最大个数显示
};


@interface YPhotoModel : NSObject


/**
 显示类型，默认9宫格
 */
@property (nonatomic, assign) YPhotoViewType photoViewType;

/**
 所以图片的imageUrl数组
 */
@property (nonatomic, strong) NSArray *imageUrlArray;

/**
 显示图片最大宽度
 */
@property (nonatomic, assign) CGFloat maxWidth;

/**
 最多显示几张图片 默认9张
 */
@property (nonatomic, assign) NSInteger imageCount;

/**
 整个photoView的高度
 */
@property (nonatomic, assign) CGFloat imagesViewHeight;

@property (nonatomic, assign) CGFloat margin;

/**
 指定首张图图片显示比例 默认16:9
 */
@property (nonatomic, assign) CGFloat firstImageScale;

/*------------------9宫格样式，默认首张图16:9,超过4张按照1:1显示，每行3张，低于4张按照147:110显示，每行2张-----------------------*/

/**
 指定2，4张图时，图片显示比例 默认147:110
 */
@property (nonatomic, assign) CGFloat otherImageScale;



/*------------------指定每一行显示个数，按照比例依次排列-----------------------*/

/**
 每一行显示最多图片
 */
@property (nonatomic, assign) NSInteger maxRowCount;


/**
 每一张图的显示比例
 */
@property (nonatomic, assign) CGFloat imageScale;

/**
 第一张图是否按照最大宽度显示
 */
@property (nonatomic, assign) BOOL isFirstImageShowMaxWidth;




/*------------------如果对第一张图按实际比例显示需要对下面进行设值-----------------------*/

/**
 第一张图是否按图比例进行显示
 */
@property (nonatomic, assign) BOOL isFirstImageScale;
/**
 第一张图的实际宽度
 */
@property (nonatomic, assign) CGFloat firstImageWidth;

/**
 第一张图的实际高度
 */
@property (nonatomic, assign) CGFloat firstImageHeight;

/**
 第一张图按比例显示最大高度
 */
@property (nonatomic, assign) CGFloat maxHeight;



@end

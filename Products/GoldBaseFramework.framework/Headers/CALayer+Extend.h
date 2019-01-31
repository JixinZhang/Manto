//
//  CALayer+Extend.h
//  GoldBaseFramework
//
//  Created by 王昱斌 on 2018/6/28.
//  Copyright © 2018年 wallstreetcn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN

@interface CALayer (Extend)

@property (nonatomic, assign, getter=bingoLeft, setter=setBingoLeft:)
CGFloat bingo_Left;
@property (nonatomic, assign, getter=bingoTop, setter=setBingoTop:)
CGFloat bingo_Top;
@property (nonatomic, assign, getter=bingoRight, setter=setBingoRight:)
CGFloat bingo_Right;
@property (nonatomic, assign, getter=bingoBottom, setter=setBingoBottom:)
CGFloat bingo_Bottom;
@property (nonatomic, assign, getter=bingoWidth, setter=setBingoWidth:)
CGFloat bingo_Width;
@property (nonatomic, assign, getter=bingoHeight, setter=setBingoHeight:)
CGFloat bingo_Height;

@property (nonatomic, assign, getter=bingoCenter, setter=setBingoCenter:)
CGPoint bingo_Center;
@property (nonatomic, assign, getter=bingoOrigin, setter=setBingoOrigin:)
CGPoint bingo_Origin;

@property (nonatomic, assign, getter=bingoSize, setter=setBingoSize:)
CGSize bingo_Size;

@property (nonatomic, assign, getter=bingoTransformRotation, setter=setBingoTransformRotation:)
CGFloat bingo_TransformRotation;
@property (nonatomic, assign, getter=bingoTransformRotationX, setter=setBingoTransformRotationX:)
CGFloat bingo_TransformRotationX;
@property (nonatomic, assign, getter=bingoTransformRotationY, setter=setBingoTransformRotationY:)
CGFloat bingo_TransformRotationY;
@property (nonatomic, assign, getter=bingoTransformRotationZ, setter=setBingoTransformRotationZ:)
CGFloat bingo_TransformRotationZ;
@property (nonatomic, assign, getter=bingoTransformScale, setter=setBingoTransformScale:)
CGFloat bingo_TransformScale;
@property (nonatomic, assign, getter=bingoTransformScaleX, setter=setBingoTransformScaleX:)
CGFloat bingo_TransformScaleX;
@property (nonatomic, assign, getter=bingoTransformScaleY, setter=setBingoTransformScaleY:)
CGFloat bingo_TransformScaleY;
@property (nonatomic, assign, getter=bingoTransformScaleZ, setter=setBingoTransformScaleZ:)
CGFloat bingo_TransformScaleZ;
@property (nonatomic, assign, getter=bingoTransformTranslationX, setter=setBingoTransformTranslationX:)
CGFloat bingo_TransformTranslationX;
@property (nonatomic, assign, getter=bingoTransformTranslationY, setter=setBingoTransformTranslationY:)
CGFloat bingo_TransformTranslationY;
@property (nonatomic, assign, getter=bingoTransformTranslationZ, setter=setBingoTransformTranslationZ:)
CGFloat bingo_TransformTranslationZ;
@property (nonatomic, assign, getter=bingoTransformDepth, setter=setBingoTransformDepth:)
CGFloat bingo_TransformDepth;

- (void)bingo_RemoveAllSublayers;

- (nullable UIImage *)screenshotImage;

- (nullable NSData *)screenshotPDF;


@end

NS_ASSUME_NONNULL_END

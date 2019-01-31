//
//  NSData+GenerateQRCode.h
//  GoldBaseFramework
//
//  Created by Micker on 2017/5/3.
//  Copyright © 2017年 wallstreetcn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreImage/CoreImage.h>
#import <AVFoundation/AVFoundation.h>


#pragma mark --
#pragma mark NSData (GenerateQRCode)

@interface NSData (GenerateQRCode)


/**
 生成普通二维码图片

 @param width 图片宽、高
 @return 生成的二维码图片
 */
- (UIImage *) generateQRCodeWithWidth:(float)width;


/**
 生成带有Logo二维码图片


 @param logoImageName Logo
 @param scale 绽放比
 @return 生成的二维码图片
 */
- (UIImage *) generateQRCodeWithLogo:(NSString *)logoImageName scale:(CGFloat)scale;


/**
 生成带有背景色的二维码图片


 @param mainColor 主颜色
 @param backgroundColor 背景色
 @return 生成的二维码图片
 */
- (UIImage *) generateQRCodeWithMainColor:(CIColor *)mainColor backgroundColor:(CIColor *)backgroundColor;

@end


#pragma mark --
#pragma mark NSString (GenerateQRCode)


@interface NSString (GenerateQRCode)


/**
 生成普通二维码图片
 
 @param width 图片宽、高
 @return 生成的二维码图片
 */
- (UIImage *) generateQRCodeWithWidth:(float)width;


/**
 生成带有Logo二维码图片
 
 
 @param logoImageName Logo
 @param scale 绽放比
 @return 生成的二维码图片
 */
- (UIImage *) generateQRCodeWithLogo:(NSString *)logoImageName scale:(CGFloat)scale;


/**
 生成带有背景色的二维码图片
 
 
 @param mainColor 主颜色
 @param backgroundColor 背景色
 @return 生成的二维码图片
 */
- (UIImage *) generateQRCodeWithMainColor:(CIColor *)mainColor backgroundColor:(CIColor *)backgroundColor;
@end

#pragma mark --
#pragma mark NSURL (GenerateQRCode)


@interface NSURL (GenerateQRCode)


/**
 生成普通二维码图片
 
 @param width 图片宽、高
 @return 生成的二维码图片
 */
- (UIImage *) generateQRCodeWithWidth:(float)width;


/**
 生成带有Logo二维码图片
 
 
 @param logoImageName Logo
 @param scale 绽放比
 @return 生成的二维码图片
 */
- (UIImage *) generateQRCodeWithLogo:(NSString *)logoImageName scale:(CGFloat)scale;


/**
 生成带有背景色的二维码图片
 
 
 @param mainColor 主颜色
 @param backgroundColor 背景色
 @return 生成的二维码图片
 */
- (UIImage *) generateQRCodeWithMainColor:(CIColor *)mainColor backgroundColor:(CIColor *)backgroundColor;

@end

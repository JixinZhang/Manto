//
//  GradientLayer.h
//  MCommonUI
//
//  Created by hushaohua on 2017/2/22.
//  Copyright © 2017年 WSCN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HGradientLayer : NSObject

+ (CALayer *) layerWithFrame:(CGRect)frame
                      colors:(NSArray *)colors
                   locations:(NSArray *)locations;

+ (CALayer *) layerWithFrame:(CGRect)frame
                      colors:(NSArray *)colors;

@end

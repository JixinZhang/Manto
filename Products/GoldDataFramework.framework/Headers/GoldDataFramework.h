//
//  GoldDataFramework.h
//  GoldDataFramework
//
//  Created by Micker on 16/5/16.
//  Copyright © 2016年 wallstreetcn. All rights reserved.
//

#import <UIKit/UIKit.h>

//! Project version number for GoldDataFramework.
FOUNDATION_EXPORT double GoldDataFrameworkVersionNumber;

//! Project version string for GoldDataFramework.
FOUNDATION_EXPORT const unsigned char GoldDataFrameworkVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <GoldDataFramework/PublicHeader.h>

#import <UIKit/UIKit.h>

#if __has_include(<GoldDataFramework/GoldDataFramework.h>)

#import <GoldDataFramework/GoldDataOperateCenter.h>

#else 

#import "GoldDataOperateCenter.h"

#endif
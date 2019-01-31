//
//  TTHome.h
//  TTHome
//
//  Created by AlexZhang on 2019/1/31.
//  Copyright © 2019 AlexZhang. All rights reserved.
//

#import <UIKit/UIKit.h>

//! Project version number for TTHome.
FOUNDATION_EXPORT double TTHomeVersionNumber;

//! Project version string for TTHome.
FOUNDATION_EXPORT const unsigned char TTHomeVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <TTHome/PublicHeader.h>

#if __has_include(<TTHome/TTHomeFramework.h>)

#import <TTHome/HomeAppDelegate.h>
#import <TTHome/TTOnTabServiceImpl.h>
#else

#import "HomeAppDelegate.h"
#import "TTOnTabServiceImpl.h"

#endif

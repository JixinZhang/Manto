//
//  TTChannel.h
//  TTChannel
//
//  Created by AlexZhang on 2019/2/13.
//  Copyright © 2019 AlexZhang. All rights reserved.
//

#import <UIKit/UIKit.h>

//! Project version number for TTChannel.
FOUNDATION_EXPORT double TTChannelVersionNumber;

//! Project version string for TTChannel.
FOUNDATION_EXPORT const unsigned char TTChannelVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <TTChannel/PublicHeader.h>

#if __has_include(<TTChannel/TTChannel.h>)

// #import <TTChannel/PublicHeader.h>
#import <TTChannel/TTChannelViewController.h>
#import <TTChannel/TTChannelViewPresenterProtocol.h>
#import <TTChannel/TTChannelCollectionViewCell.h>
#import <TTChannel/TTPlainTableCollectionViewCell.h>
#import <TTChannel/TTGroupTableCollectionViewCell.h>

#else

// #import "PublicHeader.h"
#import "TTChannelViewController.h"
#import "TTChannelViewPresenterProtocol.h"
#import "TTChannelCollectionViewCell.h"
#import "TTPlainTableCollectionViewCell.h"
#import "TTGroupTableCollectionViewCell.h"

#endif



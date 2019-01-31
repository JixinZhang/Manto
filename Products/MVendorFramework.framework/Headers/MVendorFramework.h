//
//  MVendorFramework.h
//  MVendorFramework
//
//  Created by Micker on 16/7/25.
//  Copyright © 2016年 Micker. All rights reserved.
//

#import <UIKit/UIKit.h>

//! Project version number for MVendorFramework.
FOUNDATION_EXPORT double MVendorFrameworkVersionNumber;

//! Project version string for MVendorFramework.
FOUNDATION_EXPORT const unsigned char MVendorFrameworkVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <MVendorFramework/PublicHeader.h>

#if __has_include(<MVendorFramework/MVendorFramework.h>)

#import <MVendorFramework/MBProgressHUD.h>
#import <MVendorFramework/MBProgressHUD+Add.h>
#import <MVendorFramework/TTTAttributedLabel.h>
#import <MVendorFramework/FDTemplateLayoutCell.h>
#import <MVendorFramework/UINavigationController+FDFullscreenPopGesture.h>
#import <MVendorFramework/YYModel.h>
#import <MVendorFramework/Masonry.h>
#import <MVendorFramework/YYText.h>
#import <MVendorFramework/TFHpple.h>
//#import <MVendorFramework/NWLiveRoomRefreshGifHeader.h>
//#import <MVendorFramework/MJRefresh.h>
#import <MVendorFramework/HTMLParser.h>
#import <MVendorFramework/YYWebImage.h>
#import <MVendorFramework/HLiveNewsContentParser.h>
//#import <MVendorFramework/UIView+YLoadingPanelView.h>
#import <MVendorFramework/HXPhotoPicker.h>
#import <MVendorFramework/GRichHtmlTextParser.h>
#import <MVendorFramework/NSObject+YYAddForKVO.h>

#else

#import "MBProgressHUD.h"
#import "MBProgressHUD+Add.h"
#import "TTTAttributedLabel.h"
#import "FDTemplateLayoutCell.h"
#import "UINavigationController+FDFullscreenPopGesture.h"
#import "YYModel.h"
#import "Masonry.h"
#import "YText.h"
#import "TFHpple.h"
//#import "NWLiveRoomRefreshGifHeader.h"
//#import "MJRefresh.h"
//#import "UIView+YLoadingPanelView.h"
#import "HTMLParser.h"
#import "YYWebImage.h"
#import "HLiveNewsContentParser.h"
#import "HXPhotoPicker.h"
#import "GRichHtmlTextParser.h"
#import "NSObject+YYAddForKVO.h"

#endif

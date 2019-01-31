//
//  GoldBaseFramework.h
//  GoldBaseFramework
//
//  Created by Micker on 16/5/5.
//  Copyright © 2016年 wallstreetcn. All rights reserved.
//

#import <UIKit/UIKit.h>

//! Project version number for GoldBaseFramework.
FOUNDATION_EXPORT double GoldBaseFrameworkVersionNumber;

//! Project version string for GoldBaseFramework.
FOUNDATION_EXPORT const unsigned char GoldBaseFrameworkVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <GoldBaseFramework/PublicHeader.h>


#if __has_include(<GoldBaseFramework/GoldBaseFramework.h>)

#import <GoldBaseFramework/WSCN_Categories.h>
#import <GoldBaseFramework/BaseViewController.h>
#import <GoldBaseFramework/BaseTableViewController.h>
#import <GoldBaseFramework/BaseNavigationViewController.h>
#import <GoldBaseFramework/ThemeManager.h>
#import <GoldBaseFramework/ThemeManager+FontSize.h>
#import <GoldBaseFramework/UIFont+AutoFontSize.h>
#import <GoldBaseFramework/ThemeView.h>
#import <GoldBaseFramework/LNTheme.h>
#import <GoldBaseFramework/LNThemePicker.h>
#import <GoldBaseFramework/NSObject+LNTheme.h>
#import <GoldBaseFramework/BaseTableViewPresenter.h>
#import <GoldBaseFramework/GoldDefines.h>
#import <GoldBaseFramework/FloatComparison.h>
#import <GoldBaseFramework/BaseEmptyView.h>
#import <GoldBaseFramework/UIView+LoadingView.h>
#import <GoldBaseFramework/NSAttributedString+Factory.h>
#import <GoldBaseFramework/UIView+HAutoLayout.h>
#import <GoldBaseFramework/UITableViewCell+BackgroundColor.h>
#import <GoldBaseFramework/BaseBottomView.h>
#import <GoldBaseFramework/BaseCollectionViewPresenter.h>
#import <GoldBaseFramework/BaseCollectionViewController.h>
#import <GoldBaseFramework/ZSortCollectionView.h>
#import <GoldBaseFramework/ZChannelsSort.h>
#import <GoldBaseFramework/FontPicker.h>
#import <GoldBaseFramework/GFPSStatus.h>
#import <GoldBaseFramework/ErrorResetLoadingView.h>
#import <GoldBaseFramework/GoldMemoryUsage.h>
#import <GoldBaseFramework/UILabel+ChangeLineSpaceAndWordSpace.h>
#import <GoldBaseFramework/GKeyChain.h>
#import <GoldBaseFramework/UIDevice+DeviceID.h>
#import <GoldBaseFramework/UIView+WSCNBadgeView.h>
#import <GoldBaseFramework/NSObject+Recursive.h>
#import <GoldBaseFramework/CALayer+Skeleton.h>
#import <GoldBaseFramework/UIView+Skeleton.h>
#import <GoldBaseFramework/UIScrollView+Skeleton.h>
#import <GoldBaseFramework/UIKit+MultilineText.h>
#import <GoldBaseFramework/UIKit+PrepareForSkeleton.h>
#import <GoldBaseFramework/MSkeletonLayer.h>
#import <GoldBaseFramework/SkeletonCollectionDataSource.h>
#import <GoldBaseFramework/NSObject+GCD.h>
#import <GoldBaseFramework/JRSwizzle.h>
#else

#import "WSCN_Categories.h"
#import "BaseViewController.h"
#import "BaseTableViewController.h"
#import "BaseNavigationViewController.h"
#import "ThemeManager.h"
#import "ThemeManager+FontSize.h"
#import "UIFont+AutoFontSize.h"
#import "ThemeView.h"
#import "LNTheme.h"
#import "LNThemePicker.h"
#import "NSObject+LNTheme.h"
#import "BaseTableViewPresenter.h"
#import "GoldDefines.h"
#import "FloatComparison.h"
#import "BaseEmptyView.h"
#import "UIView+LoadingView"
#import "NSAttributedString+Factory.h"
#import "UIView+HAutoLayout.h"
#import "UITableViewCell+BackgroundColor.h"
#import "BaseBottomView.h"
#import "FontPicker.h"
#import "BaseCollectionViewPresenter.h"
#import "BaseCollectionViewController.h"
#import "ZSortCollectionView.h"
#import "ZChannelsSort.h"
#import "GFPSStatus.h"
#import "ErrorResetLoadingView.h"
#import "GoldMemoryUsage.h"
#import "UILabel+ChangeLineSpaceAndWordSpace.h"
#import "GKeyChain.h"
#import "UIDevice+DeviceID.h"
#import "UIView+WSCNBadgeView.h"
#import "NSObject+Recursive.h"
#import "CALayer+Skeleton.h"
#import "UIView+Skeleton.h"
#import "UIScrollView+Skeleton.h"
#import "UIKit+MultilineText.h"
#import "UIKit+PrepareForSkeleton.h"
#import "MSkeletonLayer.h"
#import "SkeletonCollectionDataSource.h"
#import "NSObject+GCD.h"
#import "JRSwizzle.h"
#endif

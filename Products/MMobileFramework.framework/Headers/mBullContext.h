//
//  mBullContext.h
//  MobileFramework
//
//  Created by micker on 15/5/14.
//  Copyright (c) 2015年 Micker.cn  All rights reserved.
//

#import <Foundation/Foundation.h>
#import "mBullAppInterface.h"
#import "mBullContextInterface.h"

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus
    
BOOL mBullInit(NSString* appKey, Class appInterfaceClass);
id<mBullContext> mBull();
    
#ifdef __cplusplus
}
#endif // __cplusplus
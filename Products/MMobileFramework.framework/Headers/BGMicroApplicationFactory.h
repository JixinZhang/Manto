//
//  BGMicroApplicationFactory.h
//  MobileFramework
//
//  Created by micker on 15/5/18.
//  Copyright (c) 2015年 Micker.cn  All rights reserved.
//

#import "BGMicroApplication.h"
#import "BGMicroApplicationManager.h"

@interface BGMicroApplicationFactory : NSObject

- (BGMicroApplication *) createLauncherApplication;

- (BGMicroApplication *) createWithName:(NSString *) name params:(NSDictionary *) parames;

@end

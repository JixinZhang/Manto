//
//  MMobileMarco.h
//  MMobileFramework
//
//  Created by Micker on 16/8/25.
//  Copyright © 2016年 Micker. All rights reserved.
//

#ifndef MMobileMarco_h
#define MMobileMarco_h

#ifndef MBULLDEBUG
#if DEBUG
#define MBULLDEBUG 1
#endif
#endif

#ifndef M_BULL_LOG_ENABLED
#if MBULLDEBUG
#define M_BULL_LOG_ENABLED 1
#endif
#endif

#if M_BULL_LOG_ENABLED
#define M_BULL_LOG(s, ...) NSLog(@"MBULL - %@", [NSString stringWithFormat:(s), ##__VA_ARGS__])
#else
#define M_BULL_LOG(...)
#endif

#endif /* MMobileMarco_h */

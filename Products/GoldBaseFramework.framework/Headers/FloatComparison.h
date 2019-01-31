//
//  FloatComparison.h
//  GoldBaseFramework
//
//  Created by Micker on 16/8/29.
//  Copyright © 2016年 wallstreetcn. All rights reserved.
//

#ifndef FloatComparison_h
#define FloatComparison_h

#define fequal(a,b)         (fabs((a) - (b)) < FLT_EPSILON)
#define fequalzero(a)       (fabs(a) < FLT_EPSILON)
#define flessthan(a,b)      (fabs(a) < fabs(b)+FLT_EPSILON)

#endif /* FloatComparison_h */

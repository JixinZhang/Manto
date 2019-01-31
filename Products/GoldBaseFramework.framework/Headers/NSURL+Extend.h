//
//  NSURL+Extend.h
//  comb5mios
//
//  Created by allen.wang on 8/6/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 *  @brief NSURL Extend
 */

@interface NSURL(Extend)

/**
 * @brief get query parameters array
 *
 * @return              NSArray *
 * @note                NULL: If no parameters
 */
- (NSArray *) paramContents;
    
/**
 * @brief get the value of the give parameter key
 *        the key should not be empty
 *
 * @param key         key
 *  @param [out] N/A    
 * @return             NSString *
 * @note               @"": If did not contain such value
 */
- (NSString*) valueWithKey:(const NSString *)key;


/**
 * @brief get system cached url
 *
 * @return              NSArray *
 */
+ (NSURL *) systemCachedURL;

/**
 * @brief get system temp url
 *
 * @return              NSURL *
 */
+ (NSURL *) systemTmpURL;

/**
 * @brief get query parameters dictionary
 *
 * @return              NSDictionary *
 */
- (NSDictionary *)queryParams;

@end

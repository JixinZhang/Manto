//
//  ZARPCNetworkPrivate.m
//  ZARPC
//
//  Created by AlexZhang on 2019/2/1.
//  Copyright © 2019 AlexZhang. All rights reserved.
//

#import "ZARPCNetworkPrivate.h"
#import <CommonCrypto/CommonDigest.h>

@implementation ZARPCNetworkPrivate

+ (BOOL)checkJSON:(id)json withValidator:(id)validatorJson {
    if ([json isKindOfClass:[NSDictionary class]] &&
        [validatorJson isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dict = json;
        NSDictionary *validator = validatorJson;
        
        BOOL result = YES;
        
        NSEnumerator *keys = [dict keyEnumerator];
        NSString *key;
        while ((key = [keys nextObject]) != nil) {
            id value = dict[key];
            id format = validator[key];
            
            if ([value isKindOfClass:[NSDictionary class]] ||
                [value isKindOfClass:[NSArray class]]) {
                result = [self checkJSON:value withValidator:format];
                if (!result) {
                    break;
                }
            } else {
                if (![value isKindOfClass:[format class]] &&
                    [value isKindOfClass:[NSNull class]]) {
                    result = NO;
                    break;
                }
            }
        }
        return result;
        
    } else if ([json isKindOfClass:[NSArray class]] &&
               [validatorJson isKindOfClass:[NSArray class]]) {
        NSArray *array = json;
        NSArray *validatorArray = validatorJson;
        
        if (validatorArray.count > 0) {
            
            for (int i = 0; i < array.count; i++) {
                BOOL result = [self checkJSON:array[i] withValidator:validatorJson[0]];
                if (!result) {
                    return NO;
                }
            }
        }
        return YES;
        
    } else if ([json isKindOfClass:[validatorJson class]]) {
        return YES;
        
    } else {
        return NO;
    }
}

+ (NSString *)urlStringWithOriginUrlString:(NSString *)originalUrlString appendParameters:(NSDictionary *)parameters {
    NSString *filteredUrl = originalUrlString;
    NSString *parametersString = [self urlParametersStringFromParameters:parameters];
    if (!parametersString.length) {
        return originalUrlString;
    }
    
    if ([originalUrlString rangeOfString:@"?"].location != NSNotFound) {
        filteredUrl = [filteredUrl stringByAppendingString:parametersString];
        
    } else {
        filteredUrl = [filteredUrl stringByAppendingFormat:@"?%@", [parametersString substringFromIndex:1]];
        
    }
    return filteredUrl;
}

+ (NSString *)urlParametersStringFromParameters:(NSDictionary *)parameters {
    if (!parameters.count) {
        return nil;
    }
    
    NSMutableString *urlParametersString = [NSMutableString string];
    for (NSString *key in parameters) {
        NSString *value = parameters[key];
        value = [[NSString alloc] initWithFormat:@"%@", value];
        value = [self urlEncode:value];
        [urlParametersString appendFormat:@"&%@=%@", key, value];
    }
    return urlParametersString;
}

+ (NSString *)urlEncode:(NSString *)str {
    NSString *result = (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)str, CFSTR("."), CFSTR(":/?#[]@!$&'()*+,;="), kCFStringEncodingUTF8);
    return result;
}

+ (void)addDoNotBackupAttribute:(NSString *)path {
    NSURL *url = [NSURL fileURLWithPath:path];
    NSError *error = nil;
    [url setResourceValue:[NSNumber numberWithBool:YES] forKey:NSURLIsExcludedFromBackupKey error:&error];
    if (error) {
        ERRLOG(@"error to set do not backup attribute, error = %@", error);
    }
}

+ (NSString *)md5StringFromString:(NSString *)string {
    if (string == nil || [string length] == 0) {
        return nil;
    }
    const char *value = [string UTF8String];
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, (CC_LONG)strlen(value), outputBuffer);
    
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++){
        [outputString appendFormat:@"%02x",outputBuffer[count]];
    }
    return outputString;
}

+ (NSString *)appVersionString {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

@end

@implementation ZARPCBaseRequest (ResquestAccessory)

- (void)toggleAccessoriesWillStartCallBack {
    if (!self.requestAccessories)
        return;
    
    for (id<ZARPCRequestAccessory> a in self.requestAccessories) {
        if ([a respondsToSelector:@selector(requestWillStart:)]) {
            [a requestWillStart:self];
        }
    }
}

- (void)toggleAccessoriesWillStopCallBack {
    if (!self.requestAccessories)
        return;
    
    for (id<ZARPCRequestAccessory> a in self.requestAccessories) {
        if ([a respondsToSelector:@selector(requestWillStop:)]) {
            [a requestWillStop:self];
        }
    }
}

- (void)toggleAccessoriesDidStopCallBack {
    if (!self.requestAccessories)
        return;
    
    for (id<ZARPCRequestAccessory> a in self.requestAccessories) {
        if ([a respondsToSelector:@selector(requestDidStop:)]) {
            [a requestDidStop:self];
        }
    }
}


@end

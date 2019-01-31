//
//  HLiveNewsContentParser.h
//  MLiveFramework
//
//  Created by hushaohua on 1/19/17.
//  Copyright © 2017 Micker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HLiveNewsContentComponets : NSObject

@property(nonatomic, readonly) NSString* pureString;
@property(nonatomic, readonly) NSDictionary* hrefs; //{Range:Url}
@property(nonatomic, readonly) NSArray* boldRanges;
@property(nonatomic, readonly) NSArray* searchRanges;
@property(nonatomic, readonly) NSArray* blockQuoteRanges;

@end

@interface HLiveNewsContentParser : NSObject

- (void) parserHtmlContent:(NSString *)contentHtml
                    result:(void(^)(HLiveNewsContentComponets*, HLiveNewsContentComponets*))result;

- (void) parserHtmlContent:(NSString *)contentHtml
                  moreHtml:(NSString *)moreHtml
                    result:(void(^)(HLiveNewsContentComponets*, HLiveNewsContentComponets*))result;

@end

//
//  HLiveNewsContentParser.m
//  MLiveFramework
//
//  Created by hushaohua on 1/19/17.
//  Copyright © 2017 Micker. All rights reserved.
//

#import "HLiveNewsContentParser.h"
#import "TFHpple.h"

@interface HLiveNewsContentComponets()

@property(nonatomic, strong) NSString* pureString;
@property(nonatomic, strong) NSDictionary* hrefs; //{Range:Url}
@property(nonatomic, strong) NSArray* boldRanges;
@property(nonatomic, strong) NSArray* searchRanges;
@property(nonatomic, strong) NSArray* blockQuoteRanges;

@end

@implementation HLiveNewsContentComponets

+ (HLiveNewsContentComponets *) componentsWithString:(NSString *)string
                                               hrefs:(NSDictionary *)hrefs
                                          boldRanges:(NSArray *)boldRanges
                                        searchRanges:(NSArray *)searchRanges
                                    blockQuoteRanges:(NSArray *)blockQuoteRanges{
    HLiveNewsContentComponets* components = [[HLiveNewsContentComponets alloc] init];
    components.pureString = [NSString stringWithString:string];
    components.hrefs = [NSDictionary dictionaryWithDictionary:hrefs];
    components.boldRanges = [NSArray arrayWithArray:boldRanges];
    components.searchRanges = [NSArray arrayWithArray:searchRanges];
    components.blockQuoteRanges = [NSArray arrayWithArray:blockQuoteRanges];
    return components;
}

@end

@interface HLiveNewsContentParser ()

@property (nonatomic, assign) BOOL containContentMore;
@property (nonatomic, assign) BOOL containContent;

@end

@implementation HLiveNewsContentParser

- (NSString *) escapedUrlEncodedStringFrom:(NSString *)string{
    NSMutableString* text = [[NSMutableString alloc] initWithString:string];
    [text replaceOccurrencesOfString:@"&nbsp;" withString:@"" options:NSLiteralSearch range:NSMakeRange(0, text.length)];
    [text replaceOccurrencesOfString:@"&mdash;" withString:@"--" options:NSLiteralSearch range:NSMakeRange(0, text.length)];
    [text replaceOccurrencesOfString:@"&ldquo;" withString:@"“" options:NSLiteralSearch range:NSMakeRange(0, text.length)];
    [text replaceOccurrencesOfString:@"&rdquo;" withString:@"”" options:NSLiteralSearch range:NSMakeRange(0, text.length)];
    [text replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:NSMakeRange(0, text.length)];
    return text;
}

- (void) parserHtmlContent:(NSString *)contentHtml
                  moreHtml:(NSString *)moreHtml
                    result:(void(^)(HLiveNewsContentComponets*, HLiveNewsContentComponets*))result {
    NSString *string = contentHtml;
    if (string.length > 0) {
        self.containContent = YES;
        if (moreHtml.length > 0) {
            self.containContentMore = YES;
            string = [string stringByAppendingString:@"\U0000e778"];
            string = [string stringByAppendingString:moreHtml];
        } else {
            self.containContentMore = NO;
        }
    } else {
        self.containContent = NO;
        self.containContentMore = moreHtml.length > 0 ? YES : NO;
        string = moreHtml;
    }
    
    [self parserHtmlContent:string result:result];
    
}

- (void) parserHtmlContent:(NSString *)contentHtml
                    result:(void(^)(HLiveNewsContentComponets*, HLiveNewsContentComponets*))result{
    
    NSString* escapedUrlEncodedContent = [[self escapedUrlEncodedStringFrom:contentHtml] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSMutableDictionary* expandHrefs = [NSMutableDictionary dictionary];
    NSMutableDictionary* shrinkHrefs = [NSMutableDictionary dictionary];
    
    NSMutableArray* expandedBoldRanges = [NSMutableArray array];
    NSMutableArray* shrinkedBoldRanges = [NSMutableArray array];
    
    NSMutableArray* shrinkedSearchRanges = [NSMutableArray array];
    NSMutableArray* expandedSearchRanges = [NSMutableArray array];

    NSMutableArray* blockQuoteRanges = [NSMutableArray array];

    NSMutableString* expandedPureString = [[NSMutableString alloc] init];
    NSMutableString* shrinkedPureString = [[NSMutableString alloc] init];
    
    NSData* data = [escapedUrlEncodedContent dataUsingEncoding:NSUTF8StringEncoding];
    
    
    TFHpple* hpple = [TFHpple hppleWithHTMLData:data];
    NSArray* elements = [hpple searchWithXPathQuery:@"/"];
    for (NSInteger idx = 0; idx < elements.count; ++idx) {
        TFHppleElement* element = elements[idx];
        
        [self parseElement:element shHrefs:shrinkHrefs shBoldRange:shrinkedBoldRanges shSearchRange:shrinkedSearchRanges exHrefs:expandHrefs exBoldRange:expandedBoldRanges exSearchRange:expandedSearchRanges ex:expandedPureString sh:shrinkedPureString blockQuoteRanges:blockQuoteRanges];

    }
    if (expandedPureString.length > 0) {
        if ([[expandedPureString substringWithRange:NSMakeRange(expandedPureString.length - 1, 1)] isEqualToString:@"\n"]) {
            [expandedPureString replaceCharactersInRange:NSMakeRange(expandedPureString.length - 1, 1) withString:@" "];
        }
        if (self.containContentMore && self.containContent) {
            [expandedPureString replaceOccurrencesOfString:@"\U0000e778" withString:@"\n" options:NSLiteralSearch range:NSMakeRange(0, expandedPureString.length)];
            [expandedPureString replaceOccurrencesOfString:@"\n\n" withString:@" \n" options:NSLiteralSearch range:NSMakeRange(0, expandedPureString.length)];
        }
       
    }
    
    if (shrinkedPureString.length > 0 && self.containContentMore && self.containContent) {
        [shrinkedPureString replaceOccurrencesOfString:@"\U0000e778" withString:@"\n" options:NSLiteralSearch range:NSMakeRange(0, shrinkedPureString.length)];
    }
    
    if (result){
        HLiveNewsContentComponets* expand = [HLiveNewsContentComponets componentsWithString:expandedPureString hrefs:expandHrefs boldRanges:expandedBoldRanges searchRanges:expandedSearchRanges blockQuoteRanges:blockQuoteRanges];
        HLiveNewsContentComponets* shrink = [HLiveNewsContentComponets componentsWithString:shrinkedPureString hrefs:shrinkHrefs boldRanges:shrinkedBoldRanges searchRanges:shrinkedSearchRanges blockQuoteRanges:blockQuoteRanges];
        result(expand, shrink);
    }
}

- (void) parseElement:(TFHppleElement *)element
                shHrefs:(NSMutableDictionary *)shHrefs
            shBoldRange:(NSMutableArray *)shBoldRange
          shSearchRange:(NSMutableArray *)shSearchRange
                exHrefs:(NSMutableDictionary *)exHrefs
            exBoldRange:(NSMutableArray *)exBoldRange
          exSearchRange:(NSMutableArray *)exSearchRange
                ex:(NSMutableString *)exstring
                sh:(NSMutableString *)shstring
     blockQuoteRanges:(NSMutableArray *)blockQuoteRanges{
    
    NSDictionary* elementAttributes = element.attributes;
    
    NSInteger shLength = shstring.length;
    NSInteger exLength = exstring.length;
    
    if (element.isTextNode){
        [shstring appendString:element.content];
        [exstring appendString:element.content];
        [shstring replaceOccurrencesOfString:@"\n" withString:@" " options:NSLiteralSearch range:NSMakeRange(0, shstring.length)];
    }
    
    
    for (TFHppleElement* subElement in element.children) {
        [self parseElement:subElement shHrefs:shHrefs shBoldRange:shBoldRange shSearchRange:shSearchRange exHrefs:exHrefs exBoldRange:exBoldRange exSearchRange:exSearchRange ex:exstring sh:shstring blockQuoteRanges:blockQuoteRanges];
    }
    if ([element.tagName isEqualToString:@"p"] || [element.tagName isEqualToString:@"br"]) {
        [exstring appendString:@"\n"];
    } else if ([element.tagName isEqualToString:@"a"] && [elementAttributes objectForKey:@"href"]){
        NSValue* exRangeValue = [NSValue valueWithRange:NSMakeRange(exLength, exstring.length - exLength)];
        NSValue* shRangeValue = [NSValue valueWithRange:NSMakeRange(shLength, shstring.length - shLength)];
        [exHrefs setObject:[elementAttributes objectForKey:@"href"] forKey:exRangeValue];
        [shHrefs setObject:[elementAttributes objectForKey:@"href"] forKey:shRangeValue];
    } else if (exBoldRange != nil && shBoldRange != nil && ([element.tagName isEqualToString:@"b"] || [element.tagName isEqualToString:@"strong"])){
        [exBoldRange addObject:[NSValue valueWithRange:NSMakeRange(exLength, exstring.length - exLength)]];
        [shBoldRange addObject:[NSValue valueWithRange:NSMakeRange(shLength, shstring.length - shLength)]];
    } else if (exSearchRange != nil && shSearchRange != nil && [element.tagName isEqualToString:@"em"]){
        [exSearchRange addObject:[NSValue valueWithRange:NSMakeRange(exLength, exstring.length - exLength)]];
        [shSearchRange addObject:[NSValue valueWithRange:NSMakeRange(shLength, shstring.length - shLength)]];
    }else if (blockQuoteRanges != nil && blockQuoteRanges != nil && [element.tagName isEqualToString:@"blockquote"]){
        [blockQuoteRanges addObject:[NSValue valueWithRange:NSMakeRange(exLength, exstring.length - exLength)]];

    }
    
}

@end

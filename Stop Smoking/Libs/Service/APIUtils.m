//
//  APIUtils.m
//  SpayceBook
//
//  Created by Dmitry Miller on 7/4/13.
//  Copyright (c) 2013 Spayce Inc. All rights reserved.
//

#import "APIUtils.h"
#import "APIService.h"
#import <CommonCrypto/CommonDigest.h>

static NSString * IMAGE_URL_SUFFIX_DEFAULT = @"";
static NSString * IMAGE_URL_SUFFIX_THUMB = @"__thumb";
static NSString * IMAGE_URL_SUFFIX_HALF_SQUARE = @"__half_square";
static NSString * IMAGE_URL_SUFFIX_SQUARE = @"__square";

@implementation APIUtils

#pragma mark - Private

+ (NSString *)safeUrlStringFromString:(NSString *)string {
    __autoreleasing NSString *encodedString;
    
    encodedString = (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(
                                                                                          NULL,
                                                                                          (__bridge CFStringRef)string,
                                                                                          NULL,
                                                                                          (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",
                                                                                          kCFStringEncodingUTF8
                                                                                          );
    return encodedString;
}

#pragma mark - Query

+ (NSString *)queryStringForParams:(NSDictionary *)queryParamsDict {
    if (queryParamsDict == nil) {
        return nil;
    }

    NSMutableString *query = [[NSMutableString alloc] init];
    BOOL isFirstEntry = YES;

    for (NSString *key in queryParamsDict.allKeys) {
        if (isFirstEntry) {
            isFirstEntry = NO;
        } else {
            [query appendString:@"&"];
        }

        [query appendString:[APIUtils safeUrlStringFromString:key]];
        [query appendString:@"="];
        
        NSObject *value =  queryParamsDict[key];
        NSString *strValue = [value isKindOfClass:[NSString class]] ? (NSString *)value : [value description];
        [query appendString:[APIUtils safeUrlStringFromString:strValue]];
    }

    return query;
}

+ (NSString *)md5:(NSString *)input {
    const char *cStr = [input cStringUsingEncoding:NSUTF8StringEncoding];
    unsigned char digest[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), digest); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];

    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%2x", digest[i]];
    }

    return [output stringByReplacingOccurrencesOfString:@" " withString:@""];
}


@end

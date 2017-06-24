//
//  NSString+MFURLEncodingDecoding.m
//  FoundationExtensions
//
//  Created by ZhangTinghui on 2017/6/24.
//  Copyright © 2017年 www.morefun.mobi. All rights reserved.
//

#import "NSString+MFURLEncodingDecoding.h"

@implementation NSString (MFURLEncodingDecoding)

#pragma mark - URL => most from https://github.com/nicklockwood/RequestUtils with some modify
#pragma mark URL Encode/Decode
- (NSString *)mf_urlDecode {
    return [self _mf_urlDecode:NO];
}

- (NSString *)_mf_urlDecode:(BOOL)decodePlusAsSpace {
    NSString *string = self;
    if (decodePlusAsSpace) {
        string = [string stringByReplacingOccurrencesOfString:@"+" withString:@" "];
    }
    return [string stringByRemovingPercentEncoding];
}

- (NSString *)mf_urlEncode {
    static NSCharacterSet *allowedChars;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        static NSString * const disallowedChars = @"!@#$%&*()+'\";:=,/?[] ";
        allowedChars = [[NSCharacterSet characterSetWithCharactersInString:disallowedChars] invertedSet];
    });
    
    return [self stringByAddingPercentEncodingWithAllowedCharacters:allowedChars];
}

- (NSString *)mf_urlEncodeOnce {
    //url prefix encode once
    NSString *prefix = self.mf_deleteURLFragmentString.mf_deleteURLQueryString.mf_urlDecode;
    NSMutableCharacterSet *set = [[NSCharacterSet URLHostAllowedCharacterSet] mutableCopy];
    [set formUnionWithCharacterSet:[NSCharacterSet URLPathAllowedCharacterSet]];
    prefix = [prefix stringByAddingPercentEncodingWithAllowedCharacters:set];
    //url fragment encode once
    NSString *fragmentString = self.mf_urlFragmentString.mf_urlDecode;
    fragmentString = [fragmentString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    //url query encode once
    NSString *queryString = [NSString mf_queryStringForParameters:self.mf_urlQueryParameters];
    return [[prefix mf_stringByAppendingURLQuery:queryString] mf_stringByAppendingURLFragment:fragmentString];
}

#pragma mark URL Query
- (NSRange)_rangeOfURLQueryString {
    NSRange queryRange = NSMakeRange(0, self.length);
    
    NSRange fragmentStart = [self rangeOfString:@"#"];
    if (fragmentStart.location != NSNotFound) {
        queryRange.length -= (queryRange.length - fragmentStart.location);
    }
    
    NSRange queryStart = [self rangeOfString:@"?"];
    if (queryStart.location != NSNotFound) {
        queryRange.location = queryStart.location;
        queryRange.length -= queryRange.location;
    }
    
    NSString *queryString = [self substringWithRange:queryRange];
    if (queryStart.location != NSNotFound || [queryString rangeOfString:@"="].location != NSNotFound) {
        return queryRange;
    }
    
    return NSMakeRange(NSNotFound, 0);
}

- (NSString *)mf_urlQueryString {
    NSRange range = [self _rangeOfURLQueryString];
    if (range.location == NSNotFound) {
        return nil;
    }
    NSString *queryString = [self substringWithRange:range];
    if ([queryString hasPrefix:@"?"]) {
        queryString = [queryString substringFromIndex:1];
    }
    return queryString;
}

- (NSString *)mf_deleteURLQueryString {
    NSRange range = [self _rangeOfURLQueryString];
    if (range.location != NSNotFound) {
        NSString *prefix = [self substringToIndex:range.location];
        NSString *suffix = [self substringFromIndex:range.location + range.length];
        return [prefix stringByAppendingString:suffix];
    }
    return self;
}

- (NSString *)mf_stringByAppendingURLQuery:(NSString *)query {
    NSString *appendQueryString = query.mf_urlQueryString;
    if (appendQueryString == nil || appendQueryString.length <= 0) {
        return self;
    }
    
    NSString *result = self;
    NSString *fragment = result.mf_urlFragmentString;
    result = result.mf_deleteURLFragmentString;
    NSString *existingQueryString = result.mf_urlQueryString;
    if (existingQueryString.length != 0) {
        result = [result stringByAppendingFormat:@"&%@", appendQueryString];
    }
    else {
        result = [result.mf_deleteURLQueryString stringByAppendingFormat:@"?%@", appendQueryString];
    }
    
    if (fragment.length != 0) {
        result = [result stringByAppendingFormat:@"#%@", fragment];
    }
    
    return result;
}

- (NSString *)mf_stringByReplacingURLQueryWithQuery:(NSString *)query {
    return [self.mf_deleteURLQueryString mf_stringByAppendingURLQuery:query];
}

- (nonnull NSDictionary<NSString *, NSString *> *)mf_urlQueryParameters {
    NSString *queryString = self.mf_urlQueryString;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    for (NSString *param in [queryString componentsSeparatedByString:@"&"]) {
        NSRange seperatorRange = [param rangeOfString:@"="];
        if (seperatorRange.location == NSNotFound) {
            continue;
        }
        
        NSString *key = [param substringToIndex:seperatorRange.location];
        NSString *value = (param.length > seperatorRange.location + seperatorRange.length?
                           [param substringFromIndex:seperatorRange.location + seperatorRange.length]: @"");
        if (key != nil && value != nil) {
            [params setObject:value forKey:key];
        }
    }
    
    return params;
}

+ (nullable NSString *)mf_queryStringForParameters:(NSDictionary<NSString *, id> *)parameters {
    NSMutableString *result = [NSMutableString string];
    [parameters enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        //make sure key and value only be encode once
        NSString *encodedKey = key.mf_urlDecode.mf_urlEncode;
        NSAssert([obj respondsToSelector:@selector(description)], @"can't get value description, maybe you need convert it to a string");
        NSString *encodeValue = [obj description].mf_urlDecode.mf_urlEncode;
        if (encodedKey == nil || encodeValue == nil) {
            return;
        }
        
        [result appendFormat:@"&%@=%@", encodedKey, encodeValue];
    }];
    
    if ([result hasPrefix:@"&"]) {
        [result deleteCharactersInRange:NSMakeRange(0, 1)];
    }
    
    return (result.length > 0? result: nil);
}

#pragma mark URL Fragment
- (nullable NSString *)mf_urlFragmentString {
    NSRange fragmentStart = [self rangeOfString:@"#"];
    if (fragmentStart.location != NSNotFound){
        return [self substringFromIndex:fragmentStart.location + 1];
    }
    return nil;
}

- (NSString *)mf_deleteURLFragmentString {
    NSRange fragmentStart = [self rangeOfString:@"#"];
    if (fragmentStart.location != NSNotFound) {
        return [self substringToIndex:fragmentStart.location];
    }
    return self;
}

- (NSString *)mf_stringByAppendingURLFragment:(nullable NSString *)fragment {
    if (fragment != nil) {
        NSRange fragmentStart = [self rangeOfString:@"#"];
        if (fragmentStart.location != NSNotFound) {
            return [self stringByAppendingString:fragment];
        }
        return [self stringByAppendingFormat:@"#%@", fragment];
    }
    return self;
}

@end



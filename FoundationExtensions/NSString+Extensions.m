//
//  NSString+Extensions.m
//  Foundation+
//
//  Created by ZhangTinghui on 14/11/14.
//  Copyright (c) 2014年 codingobjc.com. All rights reserved.
//

#import <CommonCrypto/CommonDigest.h>
#import "NSString+Extensions.h"

@implementation NSString (Extensions)

#pragma mark - LocalizedString
- (NSString *)localizedString {
    return NSLocalizedString(self, nil);
}

#pragma mark - Hash
- (NSString *)MD5String {
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    const char *bytes = [self UTF8String];
    CC_MD5(bytes, (CC_LONG)strlen(bytes), result);
    
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3], result[4],
            result[5], result[6], result[7], result[8], result[9],
            result[10], result[11], result[12], result[13], result[14], result[15]];
}

#pragma mark - Utils
- (NSString *)trimmedString {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (BOOL)isNotNilOrWhiteSpace {
    return (self != nil? self.trimmedString.length > 0: NO);
}

- (BOOL)isAlphabetOrNumbers {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^[a-zA-Z0-9]+$"];
    return [predicate evaluateWithObject:self];
}

- (BOOL)isValidEmail {
    BOOL stricterFilter = NO; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

- (BOOL)isChineseCellPhoneNumber {
    //    NSString *regex = @"^((13[0-9])|(145)|(147)|(15[^4,\\D])|(18[0-9]))\\d{8}$";
    NSString *regex = @"^(1[3-9][0-9])\\d{8}$"; //only keep the basic rule
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:self];
}

#pragma mark - URL => most from https://github.com/nicklockwood/RequestUtils with some modify
#pragma mark URL Encode/Decode
- (NSString *)urlDecodedString {
    return [self _urlDecodedString:NO];
}

- (NSString *)_urlDecodedString:(BOOL)decodePlusAsSpace {
    NSString *string = self;
    if (decodePlusAsSpace) {
        string = [string stringByReplacingOccurrencesOfString:@"+" withString:@" "];
    }
    return [string stringByRemovingPercentEncoding];
}

- (NSString *)urlEncodedString {
    static NSCharacterSet *allowedChars;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        static NSString * const disallowedChars = @"!@#$%&*()+'\";:=,/?[] ";
        allowedChars = [[NSCharacterSet characterSetWithCharactersInString:disallowedChars] invertedSet];
    });
    
    return [self stringByAddingPercentEncodingWithAllowedCharacters:allowedChars];
}

- (NSString *)urlEncodeOnceString {
    //url prefix encode once
    NSString *prefix = self.stringByDeletingURLFragmentString.stringByDeletingURLQueryString.urlDecodedString;
    NSMutableCharacterSet *set = [[NSCharacterSet URLHostAllowedCharacterSet] mutableCopy];
    [set formUnionWithCharacterSet:[NSCharacterSet URLPathAllowedCharacterSet]];
    prefix = [prefix stringByAddingPercentEncodingWithAllowedCharacters:set];
    //url fragment encode once
    NSString *fragmentString = self.urlFragmentString.urlDecodedString;
    fragmentString = [fragmentString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    //url query encode once
    NSString *queryString = [NSString queryStringForParameters:self.urlQueryParameters];
    return [[prefix stringByAppendingURLQuery:queryString] stringByAppendingURLFragment:fragmentString];
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

- (NSString *)urlQueryString {
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

- (NSString *)stringByDeletingURLQueryString {
    NSRange range = [self _rangeOfURLQueryString];
    if (range.location != NSNotFound) {
        NSString *prefix = [self substringToIndex:range.location];
        NSString *suffix = [self substringFromIndex:range.location + range.length];
        return [prefix stringByAppendingString:suffix];
    }
    return self;
}

- (NSString *)stringByAppendingURLQuery:(NSString *)query {
    NSString *appendQueryString = query.urlQueryString;
    if (appendQueryString == nil || appendQueryString.length <= 0) {
        return self;
    }
    
    NSString *result = self;
    NSString *fragment = result.urlFragmentString;
    result = result.stringByDeletingURLFragmentString;
    NSString *existingQueryString = result.urlQueryString;
    if (existingQueryString.length != 0) {
        result = [result stringByAppendingFormat:@"&%@", appendQueryString];
    }
    else {
        result = [result.stringByDeletingURLQueryString stringByAppendingFormat:@"?%@", appendQueryString];
    }
    
    if (fragment.length != 0) {
        result = [result stringByAppendingFormat:@"#%@", fragment];
    }
    
    return result;
}

- (NSString *)stringByReplacingURLQueryWithQuery:(NSString *)query {
    return [self.stringByDeletingURLQueryString stringByAppendingURLQuery:query];
}

- (nonnull NSDictionary<NSString *, NSString *> *)urlQueryParameters {
    NSString *queryString = self.urlQueryString;
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

+ (nullable NSString *)queryStringForParameters:(NSDictionary<NSString *, id> *)parameters {
    NSMutableString *result = [NSMutableString string];
    [parameters enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        //make sure key and value only be encode once
        NSString *encodedKey = key.urlDecodedString.urlEncodedString;
        NSAssert([obj respondsToSelector:@selector(description)], @"can't get value description, maybe you need convert it to a string");
        NSString *encodeValue = [obj description].urlDecodedString.urlEncodedString;
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
- (nullable NSString *)urlFragmentString {
    NSRange fragmentStart = [self rangeOfString:@"#"];
    if (fragmentStart.location != NSNotFound){
        return [self substringFromIndex:fragmentStart.location + 1];
    }
    return nil;
}

- (NSString *)stringByDeletingURLFragmentString {
    NSRange fragmentStart = [self rangeOfString:@"#"];
    if (fragmentStart.location != NSNotFound) {
        return [self substringToIndex:fragmentStart.location];
    }
    return self;
}

- (NSString *)stringByAppendingURLFragment:(nullable NSString *)fragment {
    if (fragment != nil) {
        NSRange fragmentStart = [self rangeOfString:@"#"];
        if (fragmentStart.location != NSNotFound) {
            return [self stringByAppendingString:fragment];
        }
        return [self stringByAppendingFormat:@"#%@", fragment];
    }
    return self;
}


#pragma mark - Size
+ (NSDictionary *)_textAttributesWithFont:(UIFont *)font lineBreakMode:(NSLineBreakMode)lineBreakMode {
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineBreakMode = lineBreakMode;
    attributes[NSParagraphStyleAttributeName] = style;
    if (font != nil) {
        attributes[NSFontAttributeName] = font;
    }
    
    return attributes;
}

- (CGSize)sizeWithFont:(UIFont *)font withMaxWidth:(CGFloat)maxWidth {
    NSDictionary *attributes = [NSString _textAttributesWithFont:font lineBreakMode:NSLineBreakByCharWrapping];
    CGRect bounds = [self boundingRectWithSize:CGSizeMake(maxWidth, CGFLOAT_MAX)
                                       options:NSStringDrawingUsesLineFragmentOrigin
                                    attributes:attributes
                                       context:nil];
    return CGSizeMake(ceilf(CGRectGetWidth(bounds)),
                      ceilf(CGRectGetHeight(bounds)));
}

@end


//
//  NSString+Extensions.m
//  Foundation+
//
//  Created by ZhangTinghui on 14/11/14.
//  Copyright (c) 2014年 codingobjc.com. All rights reserved.
//

#import "NSString+Extensions.h"

@implementation NSString (Extensions)

#pragma Hash
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

#pragma Utils
- (NSString *)stringByTrimming {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (BOOL)isNotNilOrWhiteSpaceString {
    return [self stringByTrimming].length > 0;
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
    NSString *regex = @"^(1[3-9][0-9])\\d{8}$"; //only keep the basic rule on local client
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:self];
}

#pragma mark - URL
- (NSString *)URLEncodeString {
    static CFStringRef charset = CFSTR("!@#$%&*()+'\";:=,/?[] ");
    CFStringRef str = (__bridge CFStringRef)self;
    CFStringEncoding encoding = kCFStringEncodingUTF8;
    return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL, str, NULL, charset, encoding));
}

- (NSString *)urlQueryStringValueEncodeUsingUTF8Encoding {
    return [self urlQueryStringValueEncodeUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)urlQueryStringValueEncodeUsingEncoding:(NSStringEncoding)encoding {
    CFStringEncoding stringEncoding = CFStringConvertNSStringEncodingToEncoding(encoding);
    CFStringRef stringRef = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                    (CFStringRef)self,
                                                                    NULL,
                                                                    (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",
                                                                    stringEncoding);
    return (NSString *)CFBridgingRelease(stringRef);
}

- (NSString *)urlQueryStringValueDecodeUsingUTF8Encoding {
    return [self urlQueryStringValueDecodeUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)urlQueryStringValueDecodeUsingEncoding:(NSStringEncoding)encoding {
    CFStringEncoding stringEncoding = CFStringConvertNSStringEncodingToEncoding(encoding);
    CFStringRef stringRef = CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
                                                                                    (CFStringRef)self,
                                                                                    CFSTR(""),
                                                                                    stringEncoding);
    return (NSString *)CFBridgingRelease(stringRef);
}

- (NSString *)appendQueryStringKey:(NSString *)key withValue:(id)value {
    if ([value isKindOfClass:[NSNumber class]]) {
        return [self appendQueryStringKey:key withStringValue:[(NSNumber *)value stringValue]];
    }
    
    if ([value isKindOfClass:[NSString class]]) {
        return [self appendQueryStringKey:key withStringValue:value];
    }
    
    return nil;
}

- (NSString *)appendQueryStringKey:(NSString *)key withStringValue:(NSString *)value {
    if ([self rangeOfString:@"?"].length == 0) {
        return [NSString stringWithFormat:@"%@?%@=%@", [self stringByTrimming], key, [value urlQueryStringValueEncodeUsingUTF8Encoding]];
    }
    else {
        if ([self rangeOfString:@"&"].location == (self.length - 1)) {
            return [NSString stringWithFormat:@"%@%@=%@", [self stringByTrimming], key, [value urlQueryStringValueEncodeUsingUTF8Encoding]];
        }
        else {
            return [NSString stringWithFormat:@"%@&%@=%@", [self stringByTrimming], key, [value urlQueryStringValueEncodeUsingUTF8Encoding]];
        }
    }
}

- (NSDictionary *)queryStringToDictionary {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    for (NSString *param in [self componentsSeparatedByString:@"&"]) {
        NSArray *elts = [param componentsSeparatedByString:@"="];
        if([elts count] < 2) {
            continue;
        }
        [params setObject:[elts objectAtIndex:1] forKey:[elts objectAtIndex:0]];
    }
    
    return params;
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


//
//  NSString+Extensions.h
//  Foundation+
//
//  Created by ZhangTinghui on 14/11/14.
//  Copyright (c) 2014年 codingobjc.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

@interface NSString (Extensions)

#pragma Hash
- (NSString *)MD5String;


#pragma Utils
- (NSString *)stringByTrimming;

- (BOOL)isNotNilOrWhiteSpaceString;

- (BOOL)isValidEmail;

- (BOOL)isChineseCellPhoneNumber;


#pragma mark - URL
- (NSString *)URLEncodeString;

- (NSString *)urlQueryStringValueEncodeUsingUTF8Encoding;
- (NSString *)urlQueryStringValueEncodeUsingEncoding:(NSStringEncoding)encoding;

- (NSString *)urlQueryStringValueDecodeUsingUTF8Encoding;
- (NSString *)urlQueryStringValueDecodeUsingEncoding:(NSStringEncoding)encoding;

- (NSString *)appendQueryStringKey:(NSString *)key withValue:(id)value;
- (NSString *)appendQueryStringKey:(NSString *)key withStringValue:(NSString *)value;

- (NSDictionary *)queryStringToDictionary;

#pragma mark - Size
- (CGSize)sizeWithFont:(UIFont *)font withMaxWidth:(CGFloat)maxWidth;

@end

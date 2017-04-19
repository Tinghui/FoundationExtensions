//
//  NSString+Extensions.h
//  Foundation+
//
//  Created by ZhangTinghui on 14/11/14.
//  Copyright (c) 2014年 codingobjc.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#define FormatString(args...)                   [NSString stringWithFormat:args]

@interface NSString (Extensions)



#pragma mark - LocalizedString
@property (nonatomic, readonly, nonnull) NSString *localizedString;



#pragma mark - Hash
@property (nonatomic, readonly, nonnull) NSString *MD5String;



#pragma mark - Utils
@property (nonatomic, readonly, nonnull) NSString *trimmedString;
@property (nonatomic, readonly) BOOL isNotNilOrWhiteSpace;
@property (nonatomic, readonly) BOOL isAlphabetOrNumbers;
@property (nonatomic, readonly) BOOL isValidEmail;
@property (nonatomic, readonly) BOOL isChineseCellPhoneNumber;



#pragma mark - URL Encode/Decode
@property (nonatomic, readonly, nonnull) NSString *urlDecodedString;
@property (nonatomic, readonly, nonnull) NSString *urlEncodedString;
@property (nonatomic, readonly, nonnull) NSString *urlEncodeOnceString;

#pragma mark URL Query
@property (nonatomic, readonly, nullable)   NSString *urlQueryString;
@property (nonatomic, readonly, nonnull)    NSString *stringByDeletingURLQueryString;
@property (nonatomic, readonly, nonnull)    NSDictionary<NSString *, NSString *> *urlQueryParameters;

- (nonnull NSString *)stringByAppendingURLQuery:(nonnull NSString *)query;
- (nonnull NSString *)stringByReplacingURLQueryWithQuery:(nonnull NSString *)query;

+ (nullable NSString *)queryStringForParameters:(nullable NSDictionary<NSString *, id> *)parameters;

#pragma mark URL Fragment
@property (nonatomic, readonly, nullable)   NSString *urlFragmentString;
@property (nonatomic, readonly, nonnull)    NSString *stringByDeletingURLFragmentString;

- (nonnull NSString *)stringByAppendingURLFragment:(nullable NSString *)fragment;


#pragma mark - Size
- (CGSize)sizeWithFont:(nonnull UIFont *)font withMaxWidth:(CGFloat)maxWidth;

@end



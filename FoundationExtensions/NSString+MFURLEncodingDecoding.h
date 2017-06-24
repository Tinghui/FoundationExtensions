//
//  NSString+MFURLEncodingDecoding.h
//  FoundationExtensions
//
//  Created by ZhangTinghui on 2017/6/24.
//  Copyright © 2017年 www.morefun.mobi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MFURLEncodingDecoding)

#pragma mark - URL Encode/Decode
@property (nonatomic, readonly, nonnull) NSString *mf_urlDecode;
@property (nonatomic, readonly, nonnull) NSString *mf_urlEncode;
@property (nonatomic, readonly, nonnull) NSString *mf_urlEncodeOnce;

#pragma mark URL Query
@property (nonatomic, readonly, nullable)   NSString *mf_urlQueryString;
@property (nonatomic, readonly, nonnull)    NSString *mf_deleteURLQueryString;
@property (nonatomic, readonly, nonnull)    NSDictionary<NSString *, NSString *> *mf_urlQueryParameters;

- (nonnull NSString *)mf_stringByAppendingURLQuery:(nonnull NSString *)query;
- (nonnull NSString *)mf_stringByReplacingURLQueryWithQuery:(nonnull NSString *)query;

+ (nullable NSString *)mf_queryStringForParameters:(nullable NSDictionary<NSString *, id> *)parameters;

#pragma mark URL Fragment
@property (nonatomic, readonly, nullable)   NSString *mf_urlFragmentString;
@property (nonatomic, readonly, nonnull)    NSString *mf_deleteURLFragmentString;

- (nonnull NSString *)mf_stringByAppendingURLFragment:(nullable NSString *)fragment;

@end

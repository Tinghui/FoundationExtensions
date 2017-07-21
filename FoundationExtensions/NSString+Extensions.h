//
//  NSString+Extensions.h
//  Foundation+
//
//  Created by ZhangTinghui on 14/11/14.
//  Copyright (c) 2014年 www.morefun.mobi. All rights reserved.
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
@property (nonatomic, readonly) BOOL isNumbers;
@property (nonatomic, readonly) BOOL isAlphabetOrNumbers;
@property (nonatomic, readonly) BOOL isValidEmail;
@property (nonatomic, readonly) BOOL isChineseCellPhoneNumber;

#pragma mark - Size
- (CGSize)sizeWithFont:(nonnull UIFont *)font withMaxWidth:(CGFloat)maxWidth;

@end



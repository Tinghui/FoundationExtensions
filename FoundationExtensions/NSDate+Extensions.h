//
//  NSDate+Extensions.h
//  Foundation+
//
//  Created by ZhangTinghui on 14-7-15.
//  Copyright (c) 2014年 www.www.morefun.mobi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extensions)

@property (nonatomic, readonly) NSInteger year;
@property (nonatomic, readonly) NSInteger month;
@property (nonatomic, readonly) NSInteger day;
@property (nonatomic, readonly) NSInteger hour;
@property (nonatomic, readonly) NSInteger weekday;

- (nullable NSDate *)beginningOfDay;
- (BOOL)isSameDayWith:(nullable NSDate *)anotherDay;

#pragma mark - Formate
+ (nonnull NSDateFormatter *)sharedFormatter;

/** to @"yyyy-MM-dd HH:mm:ss" formate string */
- (nonnull NSString *)toSecondEndingString;

/** from @"yyyy-MM-dd HH:mm:ss" formate string */
+ (nullable NSDate *)dateFromSecondEndingString:(nonnull NSString *)dateString;

/** to @"yyyy-MM-dd HH:mm:ss:SSS" formate string */
- (nonnull NSString *)toMillionSecondEndingString;

/** from @"yyyy-MM-dd HH:mm:ss:SSS" formate string */
+ (nullable NSDate *)dateFromMillionSecondEndingString:(nonnull NSString *)dateString;

/** to @"yyyy" formate string */
- (nonnull NSString *)toYearMonthDayString;

/** from @"yyyy" formate string */
+ (nullable NSDate *)dateFromYearMonthDayEndingString:(nonnull NSString *)dateString;

/** to @"yyyy-MM-dd HH:mm" formate string */
- (nonnull NSString *)toMinutesEndingString;

/** to @"MM月dd日" formate string */
- (nonnull NSString *)toMonthDayString;

- (nonnull NSString *)toStringWithFormat:(nonnull NSString *)format;

+ (nullable NSDate *)dateFromString:(nonnull NSString *)string withFormat:(nonnull NSString *)format;

@end



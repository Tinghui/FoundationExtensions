//
//  NSDate+Extensions.h
//  Foundation+
//
//  Created by ZhangTinghui on 14-7-15.
//  Copyright (c) 2014年 www.www.morefun.mobi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extensions)

@property (nonatomic, readonly) NSInteger month;
@property (nonatomic, readonly) NSInteger day;
@property (nonatomic, readonly) NSInteger hour;
@property (nonatomic, readonly) NSInteger weekday;

- (nullable NSDate *)beginningOfDay;
- (BOOL)isSameDayWith:(nullable NSDate *)anotherDay;

- (nonnull NSString *)toSecondEndingString;
+ (nullable NSDate *)dateFromSecondEndingString:(nonnull NSString *)dateString;

- (nonnull NSString *)toMillionSecondEndingString;
+ (nullable NSDate *)dateFromMillionSecondEndingString:(nonnull NSString *)dateString;

- (nonnull NSString *)toYearMonthDayString;
+ (nullable NSDate *)dateFromYearMonthDayEndingString:(nonnull NSString *)dateString;

- (nonnull NSString *)toMinutesEndingString;

- (nonnull NSString *)toMonthDayString;

@end

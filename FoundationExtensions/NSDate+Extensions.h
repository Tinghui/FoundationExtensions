//
//  NSDate+Extensions.h
//  Foundation+
//
//  Created by ZhangTinghui on 14-7-15.
//  Copyright (c) 2014年 www.codingobjc.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extensions)

- (NSDate *)beginningOfDay;
- (BOOL)isSameDayWith:(NSDate *)anotherDay;

- (NSInteger)month;
- (NSInteger)day;
- (NSInteger)hour;
- (NSInteger)weekday;

- (NSString *)toSecondEndingString;
+ (NSDate *)dateFromSecondEndingString:(NSString *)dateString;

- (NSString *)toMillionSecondEndingString;
+ (NSDate *)dateFromMillionSecondEndingString:(NSString *)dateString;

- (NSString *)toYearMonthDayString;
+ (NSDate *)dateFromYearMonthDayEndingString:(NSString *)dateString;

- (NSString *)toMinutesEndingString;

- (NSString *)toMonthDayString;

@end

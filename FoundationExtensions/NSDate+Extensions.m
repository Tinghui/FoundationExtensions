//
//  NSDate+Extensions.m
//  Foundation+
//
//  Created by ZhangTinghui on 14-7-15.
//  Copyright (c) 2014年 www.www.morefun.mobi. All rights reserved.
//

#import "NSDate+Extensions.h"

@implementation NSDate (Extensions)

- (NSInteger)year {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear fromDate:self];
    return [components year];
}

- (NSInteger)month {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitMonth fromDate:self];
    return [components month];
}

- (NSInteger)day {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitDay fromDate:self];
    return [components day];
}

- (NSInteger)hour {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitHour fromDate:self];
    return [components hour];
}

- (NSInteger)weekday {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitWeekday fromDate:self];
    return [components weekday];
}

- (NSDate *)beginningOfDay {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay
                                               fromDate:self];
    return [calendar dateFromComponents:components];
}

- (BOOL)isSameDayWith:(NSDate *)anotherDay {
    BOOL sameDay = NO;
    if (anotherDay != nil) {
        NSCalendar *cal = [NSCalendar currentCalendar];
        NSDateComponents *comps1 = [cal components:(NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitDay)
                                          fromDate:self];
        NSDateComponents *comps2 = [cal components:(NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitDay)
                                          fromDate:anotherDay];
        sameDay = ([comps1 day] == [comps2 day]
                   && [comps1 month] == [comps2 month]
                   && [comps1 year] == [comps2 year]);
    }
    return sameDay;
}

#pragma mark - Formate
+ (NSDateFormatter *)sharedFormatter {
    static NSDateFormatter * _fmt = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _fmt = [[NSDateFormatter alloc] init];
    });
    return _fmt;
}

- (NSString *)toSecondEndingString {
    [[[self class] sharedFormatter] setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [[[self class] sharedFormatter] stringFromDate:self];
}

+ (NSDate *)dateFromSecondEndingString:(NSString*)dateString {
    [[self sharedFormatter] setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [[self sharedFormatter] dateFromString:dateString];
}

- (NSString *)toMillionSecondEndingString {
    [[[self class] sharedFormatter] setDateFormat:@"yyyy-MM-dd HH:mm:ss:SSS"];
    return [[[self class] sharedFormatter] stringFromDate:self];
}

+ (NSDate *)dateFromMillionSecondEndingString:(NSString*)dateString {
    [[self sharedFormatter] setDateFormat:@"yyyy-MM-dd HH:mm:ss:SSS"];
    return [[self sharedFormatter] dateFromString:dateString];
}

- (NSString *)toYearMonthDayString {
    [[[self class] sharedFormatter] setDateFormat:@"yyyy-MM-dd"];
    return [[[self class] sharedFormatter] stringFromDate:self];
}

+ (NSDate *)dateFromYearMonthDayEndingString:(NSString *)dateString {
    [[self sharedFormatter] setDateFormat:@"yyyy-MM-dd"];
    return [[self sharedFormatter] dateFromString:dateString];
}

- (NSString *)toMinutesEndingString {
    [[[self class] sharedFormatter] setDateFormat:@"yyyy-MM-dd HH:mm"];
    return [[[self class] sharedFormatter] stringFromDate:self];
}

- (NSString *)toMonthDayString {
    [[[self class] sharedFormatter] setDateFormat:@"MM月dd日"];
    return [[[self class] sharedFormatter] stringFromDate:self];
}

- (NSString *)toStringWithFormat:(NSString *)format {
    [[[self class] sharedFormatter] setDateFormat:format];
    return [[[self class] sharedFormatter] stringFromDate:self];
}

+ (NSDate *)dateFromString:(NSString *)string withFormat:(NSString *)format {
    [[self sharedFormatter] setDateFormat:format];
    return [[self sharedFormatter] dateFromString:string];
}

@end



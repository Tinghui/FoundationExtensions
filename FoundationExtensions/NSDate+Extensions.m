//
//  NSDate+Extensions.m
//  Foundation+
//
//  Created by ZhangTinghui on 14-7-15.
//  Copyright (c) 2014年 www.codingobjc.com. All rights reserved.
//

#import "NSDate+Extensions.h"

@implementation NSDate (Extensions)

- (NSDate *)beginningOfDay {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit
                                               fromDate:self];
    return [calendar dateFromComponents:components];
}

- (BOOL)isSameDayWith:(NSDate *)anotherDay {
    BOOL sameDay = NO;
    if (anotherDay != nil) {
        NSCalendar *cal = [NSCalendar currentCalendar];
        NSDateComponents *comps1 = [cal components:(NSMonthCalendarUnit| NSYearCalendarUnit | NSDayCalendarUnit)
                                          fromDate:self];
        NSDateComponents *comps2 = [cal components:(NSMonthCalendarUnit| NSYearCalendarUnit | NSDayCalendarUnit)
                                          fromDate:anotherDay];
        
        sameDay = ([comps1 day] == [comps2 day]
                   && [comps1 month] == [comps2 month]
                   && [comps1 year] == [comps2 year]);
    }
    
    return sameDay;
}

- (NSInteger)month {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSMonthCalendarUnit fromDate:self];
    return [components month];
}

- (NSInteger)day {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSDayCalendarUnit fromDate:self];
    return [components day];
}

- (NSInteger)hour {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSHourCalendarUnit fromDate:self];
    return [components hour];
}

- (NSInteger)weekday {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSWeekdayCalendarUnit fromDate:self];
    
    return [components weekday];
}

- (NSString *)toSecondEndingString {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [formatter stringFromDate:self];
}

+ (NSDate *)dateFromSecondEndingString:(NSString*)dateString {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [formatter dateFromString:dateString];
}

- (NSString *)toMillionSecondEndingString {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss:SSS"];
    return [formatter stringFromDate:self];
}

+ (NSDate *)dateFromMillionSecondEndingString:(NSString*)dateString {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss:SSS"];
    return [formatter dateFromString:dateString];
}

- (NSString *)toYearMonthDayString {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    return [formatter stringFromDate:self];
}

+ (NSDate *)dateFromYearMonthDayEndingString:(NSString *)dateString {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    return [formatter dateFromString:dateString];
}

- (NSString *)toMinutesEndingString {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    return [formatter stringFromDate:self];
}

- (NSString *)toMonthDayString {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM月dd日"];
    return [formatter stringFromDate:self];
}

@end

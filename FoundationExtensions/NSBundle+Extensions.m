//
//  NSBundle+Extensions.m
//  Foundation+
//
//  Created by ZhangTinghui on 14/11/14.
//  Copyright (c) 2014年 codingobjc.com. All rights reserved.
//

#import "NSBundle+Extensions.h"

@implementation NSBundle (Extensions)

+ (nullable NSString *)bundleDisplayName {
    return [[self mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
}

+ (nullable NSString *)bundleIdentifier {
    return [[self mainBundle] objectForInfoDictionaryKey:@"CFBundleIdentifier"];
}

+ (nullable NSString *)bundleShortVersion {
    return [[self mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
}

+ (nullable NSString *)bundleBuildVersion {
    return [[self mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
}

@end

//
//  NSBundle+Extensions.h
//  Foundation+
//
//  Created by ZhangTinghui on 14/11/14.
//  Copyright (c) 2014年 codingobjc.com. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSBundle (Extensions)

+ (nullable NSString *)bundleDisplayName;

+ (nullable NSString *)bundleIdentifier;

+ (nullable NSString *)bundleShortVersion;

+ (nullable NSString *)bundleBuildVersion;
    
@end

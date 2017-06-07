//
//  NSError+Extensions.m
//  Foundation+
//
//  Created by ZhangTinghui on 14-6-17.
//  Copyright (c) 2014年 www.www.morefun.mobi. All rights reserved.
//

#import "NSError+Extensions.h"

@implementation NSError (Extensions)

+ (nonnull instancetype)errorWithCode:(NSInteger)code localizedDescription:(nullable NSString *)description {
    return [self errorWithDomain:@"Undefined error domain" code:code localizedDescription:description];
}

+ (nonnull instancetype)errorWithDomain:(nonnull NSString *)domain
                                   code:(NSInteger)code
                   localizedDescription:(nullable NSString *)description {
    NSDictionary *userInfo = nil;
    if (description) {
        userInfo = @{NSLocalizedDescriptionKey: description,
                     NSLocalizedFailureReasonErrorKey: description};
    }
    
    return [NSError errorWithDomain:domain code:code userInfo:userInfo];
}

@end

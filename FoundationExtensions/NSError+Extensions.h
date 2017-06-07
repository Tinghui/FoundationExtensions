//
//  NSError+Extensions.h
//  Foundation+
//
//  Created by ZhangTinghui on 14-6-17.
//  Copyright (c) 2014年 www.www.morefun.mobi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSError (Extensions)

+ (nonnull instancetype)errorWithCode:(NSInteger)code localizedDescription:(nullable NSString *)description;

+ (nonnull instancetype)errorWithDomain:(nonnull NSString *)domain
                                   code:(NSInteger)code
                   localizedDescription:(nullable NSString *)description;

@end

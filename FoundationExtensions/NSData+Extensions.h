//
//  NSData+Extensions.h
//  Foundation+
//
//  Created by ZhangTinghui on 14/11/14.
//  Copyright (c) 2014年 codingobjc.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

@interface NSData (Extensions)

@property (nonatomic, readonly, nonnull) NSString *MD5String;

@end

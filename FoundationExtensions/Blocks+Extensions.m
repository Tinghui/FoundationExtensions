//
//  Blocks+Extensions.m
//  FoundationExtensions
//
//  Created by ZhangTinghui on 16/2/16.
//  Copyright © 2016年 www.morefun.mobi. All rights reserved.
//

#import "Blocks+Extensions.h"

@implementation BlockStatus

@end


BlockStatus* dispatch_async_with_status(dispatch_queue_t queue, BlockStatus_t block) {
    BlockStatus *status = [[BlockStatus alloc] init];
    dispatch_sync(queue, ^{
        if (block == nil) {
            return;
        }
        
        block(status);
    });
    return status;
}



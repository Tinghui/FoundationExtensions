//
//  Blocks+Extensions.h
//  Foundation+
//
//  Created by ZhangTinghui on 14/11/13.
//  Copyright (c) 2014年 codingobjc.com. All rights reserved.
//

#ifndef Extensions_Blocks_Extensions_h
#define Extensions_Blocks_Extensions_h

#import <Foundation/Foundation.h>
#import <dispatch/dispatch.h>

typedef void(^CommonVoidBlock)(void);
typedef void(^CommonObjectBlock)(id obj);
typedef void(^CommonErrorBlock)(NSError *error);


@interface BlockStatus : NSObject
@property (assign, getter = isCancelled) BOOL cancel;
@end

typedef void(^BlockStatus_t)(BlockStatus *blockStatus);
BlockStatus* dispatch_async_with_status(dispatch_queue_t queue, BlockStatus_t block);

#endif

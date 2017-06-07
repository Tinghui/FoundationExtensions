//
//  NSNotificationCenter+Extensions.h
//  Foundation+
//
//  Created by ZhangTinghui on 14-6-4.
//  Copyright (c) 2014年 www.www.morefun.mobi. All rights reserved.
//

#import <Foundation/NSNotification.h>

#define NSNotificationAdd(anObserver, aSEL, noteName, anObj)    [[NSNotificationCenter defaultCenter] \
                                                                    addObserver:(anObserver) \
                                                                    selector:(aSEL) \
                                                                    name:(noteName) \
                                                                    object:(anObj)]

#define NSNotificationRemove(anObserver, notifName, anObj)      [[NSNotificationCenter defaultCenter] \
                                                                    removeObserver:(anObserver) \
                                                                    name:(notifName) \
                                                                    object:(anObj)]

#define NSNotificationRemoveObserver(anObserver)				[[NSNotificationCenter defaultCenter] \
                                                                    removeObserver:(anObserver)]

#define NSNotificationPost(notifName, anObj, anUserInfo)		[[NSNotificationCenter defaultCenter] \
                                                                    postNotificationName:(notifName) \
                                                                    object:(anObj) \
                                                                    userInfo:(anUserInfo)]

#define NSNotificationPostOnMainThread(notifName, anObj, anUserInfo) dispatch_async(dispatch_get_main_queue(), ^(void){\
                                                                        [[NSNotificationCenter defaultCenter] \
                                                                         postNotificationName:(notifName) \
                                                                         object:(anObj) \
                                                                         userInfo:(anUserInfo)];\
                                                                    });\

@interface NSNotificationCenter (Extensions)

@end

//
//  NSPathUtilities+Extensions.h
//  Foundation+
//
//  Created by ZhangTinghui on 14/11/13.
//  Copyright (c) 2014年 codingobjc.com. All rights reserved.
//

#ifndef Extensions_NSPathUtilities_Extensions_h
#define Extensions_NSPathUtilities_Extensions_h

#import <Foundation/Foundation.h>

#define	CacheDir()       [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]
#define LibraryDir()     [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject]
#define DocumentDir()    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]

#endif

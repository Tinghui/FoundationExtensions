//
//  NSObjCRuntime+Extensions.h
//  Foundation+
//
//  Created by ZhangTinghui on 14/11/13.
//  Copyright (c) 2014年 codingobjc.com. All rights reserved.
//

#ifndef Extensions_NSObjCRuntime_Extensionsh
#define Extensions_NSObjCRuntime_Extensionsh

#import <Foundation/Foundation.h>

/**
 *  DLog
 */
#pragma mark - DLog
#if DEBUG
#define DLog(args...)       (NSLog(@"%@", [NSString stringWithFormat:args]))
#else
#define DLog(args...)       // do nothing.
#endif

#define DLogMethodName()	DLog(@"%s", __PRETTY_FUNCTION__)
#define DLogBOOL(b)         DLog(@"%@", b? @"YES": @"NO")
#define DLogCGPoint(p)		DLog(@"CGPoint(%f, %f)", p.x, p.y)
#define DLogCGSize(s)		DLog(@"CGSize(%f, %f)", s.width, s.height)
#define DLogCGRect(r)		DLog(@"{CGRect{origin(%f, %f), size(%f, %f)}", \
                                    r.origin.x, r.origin.y, r.size.width, r.size.height)
#define DLogObject(obj)     DLog(@"%@", (obj))


/**
 *  Math
 */
#pragma mark - Math
//#define fequal(a, b)            (fabs((a) - (b)) < FLT_EPSILON)
//#define fequalzero(a)           (fabs(a) < FLT_EPSILON)
#define DegreesToRadian(x)      (M_PI * (x) / 180.0f)
#define RadianToDegrees(x)      (180.0f * (x) / M_PI)
#define RandomNumber(min, max)  ((min) + arc4random()%((max)-(min)+1))

#endif

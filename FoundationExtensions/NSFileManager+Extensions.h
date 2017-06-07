//
//  NSFileManager+Extensions.h
//  Foundation+
//
//  Created by ZhangTinghui on 14-5-26.
//  Copyright (c) 2014年 www.www.morefun.mobi. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DefaultFileManager()                      [NSFileManager defaultManager]
#define AttributesOfFileSystemForPath(path, err)  [DefaultFileManager() attributesOfFileSystemForPath:(path) \
                                                                        error:(err)]
#define AttributesOfItemAtPath(path, err)         [DefaultFileManager() attributesOfItemAtPath:(path) error:(err)]
#define SizeOfItemAtPath(path)                    [[AttributesOfItemAtPath((path), (nil)) objectForKey:NSFileSize] \
                                                        doubleValue]
#define DiskSize()                                ([[AttributesOfFileSystemForPath(NSHomeDirectory(), nil) \
                                                        objectForKey:NSFileSystemSize] doubleValue])
#define DiskFreeSize()                            ([[AttributesOfFileSystemForPath(NSHomeDirectory(), nil) \
                                                        objectForKey:NSFileSystemFreeSize] doubleValue])


@interface NSFileManager (Extensions)

#pragma mark - Directory Path
+ (nullable NSString *)cachesDirectory;
+ (nullable NSString *)documentDirectory;
+ (nullable NSString *)libraryDirectory;



#pragma mark - iCloud Directory Backup
/**
 *  Make sure directory path is existed, if not created it
 *
 *  @param directoryPath path for the directory
 */
+ (void)makeSureDirectoryExistsAtPath:(nonnull NSString *)directoryPath;


/**
 *  Set item do not be backup to iCloud
 *
 *  @param itemPath path of item
 *  @param exclude  whether is not be backup to iCloud
 *
 *  @return YES, if success; otherwise return NO.
 */
+ (BOOL)setItemAtPath:(nonnull NSString *)itemPath excludeFromiCloud:(BOOL)exclude;

@end



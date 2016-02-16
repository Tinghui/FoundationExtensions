//
//  FoundationTests.m
//  FoundationExtensions
//
//  Created by ZhangTinghui on 16/2/16.
//  Copyright © 2016年 www.morefun.mobi. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FoundationExtensions.h"

@interface FoundationTests : XCTestCase

@end

@implementation FoundationTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testNSFileManagerDirectoryPathes {
    NSString *path = [NSFileManager cachesDirectory];
    XCTAssertNotNil(path);
    DLog(@"%s => %@", __PRETTY_FUNCTION__, path);
    
    path = [NSFileManager documentDirectory];
    XCTAssertNotNil(path);
    DLog(@"%s => %@", __PRETTY_FUNCTION__, path);
    
    path = [NSFileManager libraryDirectory];
    XCTAssertNotNil(path);
    DLog(@"%s => %@", __PRETTY_FUNCTION__, path);
}

@end

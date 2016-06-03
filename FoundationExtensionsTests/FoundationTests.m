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

#pragma mark - NSString(URL) 
- (void)testURLEncodingDecoding {
    NSString *input = @"foo bar";
    XCTAssertEqualObjects(input.urlEncodedString, @"foo%20bar");
    XCTAssertEqualObjects(input.urlEncodedString.urlDecodedString, input);
}

- (void)testURLEncodeOnce {
    NSString *input0 = @"https://github.com/Tinghui/Objective-C-Style-Guide#!初始化方法";
    NSString *output0 = @"https://github.com/Tinghui/Objective-C-Style-Guide#!%E5%88%9D%E5%A7%8B%E5%8C%96%E6%96%B9%E6%B3%95";
    XCTAssertEqualObjects(input0.urlEncodeOnceString, output0);
    XCTAssertEqualObjects(output0.urlEncodeOnceString, output0);
    
    NSString *input1 = @"https://github.com/Tinghui/Objective-C-Style-Guide#初始化方法";
    NSString *output1 = @"https://github.com/Tinghui/Objective-C-Style-Guide#%E5%88%9D%E5%A7%8B%E5%8C%96%E6%96%B9%E6%B3%95";
    XCTAssertEqualObjects(input1.urlEncodeOnceString, output1);
    XCTAssertEqualObjects(output1.urlEncodeOnceString, output1);
    
    NSString *input2 = @"http://mp.weixin.qq.com/s?__biz=MjM5NTIyNTUyMQ==#wechat_redirect";
    NSString *output2 = @"http://mp.weixin.qq.com/s?__biz=MjM5NTIyNTUyMQ%3D%3D#wechat_redirect";
    XCTAssertEqualObjects(input2.urlEncodeOnceString, output2);
    
    NSString *input3 = @"http://www.cnblogs.com?next=http://www.cnblogs.com/season-huang/";
    NSString *output3 = @"http://www.cnblogs.com?next=http%3A%2F%2Fwww.cnblogs.com%2Fseason-huang%2F";
    XCTAssertEqualObjects(input3.urlEncodeOnceString, output3);
}

- (void)testSimpleQueryString {
    NSString *query = @"?foo=bar&bar=foo#end";
    NSDictionary *result = @{@"foo": @"bar", @"bar": @"foo"};
    XCTAssertEqualObjects(query.urlQueryParameters, result);
}

- (void)testAppendQuery {
    NSString *query1 = @"?foo=bar";
    NSString *query2 = @"foo=bar";
    NSString *URLString1 = @"http://apple.com?";
    NSString *URLString2 = @"http://apple.com";
    NSString *result = @"http://apple.com?foo=bar";
    XCTAssertEqualObjects([URLString1 stringByAppendingURLQuery:query1], result);
    XCTAssertEqualObjects([URLString1 stringByAppendingURLQuery:query2], result);
    XCTAssertEqualObjects([URLString2 stringByAppendingURLQuery:query1], result);
    XCTAssertEqualObjects([URLString2 stringByAppendingURLQuery:query2], result);
}

- (void)testQueryStringCreating {
    NSString *urlString = @"http://apple.com";
    NSString *result = @"http://apple.com?foo=bar";
    XCTAssertEqualObjects([urlString stringByAppendingURLQuery:[NSString queryStringForParameters:@{@"foo": @"bar"}]], result);
}

- (void)testQueryParmatersCreating {
    NSString *urlString = @"http://mp.weixin.qq.com/s?__biz=MjM5NTIyNTUyMQ==&mid=2709544856&idx=1&sn=6633c10e2d2d90f989aefbe9f62d6667&scene=1&srcid=0526eD4Ow7h4JtUTuRR3VpJI&from=groupmessage&isappinstalled=0#wechat_redirect";
    NSDictionary *result = @{@"__biz": @"MjM5NTIyNTUyMQ==",
                             @"mid": @"2709544856",
                             @"idx": @"1",
                             @"sn": @"6633c10e2d2d90f989aefbe9f62d6667",
                             @"scene": @"1",
                             @"srcid": @"0526eD4Ow7h4JtUTuRR3VpJI",
                             @"from": @"groupmessage",
                             @"isappinstalled": @"0"};
    XCTAssertEqualObjects(urlString.urlQueryParameters, result);
}

- (void)testQueryStringReplaceing {
    NSString *urlString = @"http://mp.weixin.qq.com/s?__biz=MjM5NTIyNTUyMQ==&mid=2709544856&idx=1&sn=6633c10e2d2d90f989aefbe9f62d6667&scene=1&srcid=0526eD4Ow7h4JtUTuRR3VpJI&from=groupmessage&isappinstalled=0#wechat_redirect";
    NSString *reulst = @"http://mp.weixin.qq.com/s?foo=bar#wechat_redirect";
    XCTAssertEqualObjects([urlString stringByReplacingURLQueryWithQuery:@"foo=bar"], reulst);
}

- (void)testFragmentString {
    NSString *urlString = @"http://mp.weixin.qq.com/s?__biz=MjM5NTIyNTUyMQ==&mid=2709544856&idx=1&sn=6633c10e2d2d90f989aefbe9f62d6667&scene=1&srcid=0526eD4Ow7h4JtUTuRR3VpJI&from=groupmessage&isappinstalled=0#wechat_redirect";
    NSString *result = @"http://mp.weixin.qq.com/s?__biz=MjM5NTIyNTUyMQ==&mid=2709544856&idx=1&sn=6633c10e2d2d90f989aefbe9f62d6667&scene=1&srcid=0526eD4Ow7h4JtUTuRR3VpJI&from=groupmessage&isappinstalled=0";
    XCTAssertEqualObjects(urlString.urlFragmentString, @"wechat_redirect");
    XCTAssertEqualObjects([urlString stringByDeletingURLFragmentString], result);
}



@end



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

- (void)testNSDateFormat {
    NSString *str = @"2017-10-09";
    NSDate *date = [NSDate dateFromYearMonthDayEndingString:str];
    XCTAssertTrue(date.year == 2017 && date.month == 10 && date.day == 9);
    XCTAssertTrue([[date toSecondEndingString] isEqualToString:@"2017-10-09 00:00:00"]);
    XCTAssertTrue([[date toYearMonthDayString] isEqualToString:@"2017-10-09"]);
    XCTAssertTrue([[date toStringWithFormat:@"yyyy.MM.dd"] isEqualToString:@"2017.10.09"]);
    XCTAssertTrue([[date toMonthDayString] isEqualToString:@"10月09日"]);
}

- (void)testNSFileManagerDirectoryPathes {
    NSString *path = [NSFileManager cachesDirectory];
    DLog(@"%s => %@", __PRETTY_FUNCTION__, path);
    XCTAssertTrue([path.lastPathComponent isEqualToString:@"Caches"]);
    
    path = [NSFileManager documentDirectory];
    DLog(@"%s => %@", __PRETTY_FUNCTION__, path);
    XCTAssertTrue([path.lastPathComponent isEqualToString:@"Documents"]);
    
    path = [NSFileManager libraryDirectory];
    DLog(@"%s => %@", __PRETTY_FUNCTION__, path);
    XCTAssertTrue([path.lastPathComponent isEqualToString:@"Library"]);
}

#pragma mark - NSString(Format)
- (void)testStringNumberFormat {
    XCTAssertTrue([[NSString stringFor:1.2345 keepDecimalCount:2] isEqualToString:@"1.23"]);
    XCTAssertTrue([[NSString stringFor:1.2345 keepDecimalCount:0] isEqualToString:@"1"]);
    XCTAssertTrue([[NSString stringFor:1.0000 alwaysKeepTwoDecimal:YES] isEqualToString:@"1.00"]);
    XCTAssertTrue([[NSString stringFor:1.0 alwaysKeepTwoDecimal:NO] isEqualToString:@"1"]);
    XCTAssertTrue([[NSString stringFor:1.121 alwaysKeepTwoDecimal:NO] isEqualToString:@"1.12"]);
}

#pragma mark - NSString(URL) 
- (void)testURLEncodingDecoding {
    NSString *input = @"foo bar";
    XCTAssertEqualObjects(input.mf_urlEncode, @"foo%20bar");
    XCTAssertEqualObjects(input.mf_urlEncode.mf_urlDecode, input);
    
    NSString *input1 = @"H6mXLN%2F575EsUDLVAaQ0F88R%2B1o%3D";
    NSString *output2 = @"H6mXLN/575EsUDLVAaQ0F88R+1o=";
    XCTAssertEqualObjects(input1.mf_urlDecode, output2);
    XCTAssertEqualObjects(output2.mf_urlEncode, input1);
}

- (void)testURLEncodeOnce {
    NSString *input0 = @"https://github.com/Tinghui/Objective-C-Style-Guide#!初始化方法";
    NSString *output0 = @"https://github.com/Tinghui/Objective-C-Style-Guide#!%E5%88%9D%E5%A7%8B%E5%8C%96%E6%96%B9%E6%B3%95";
    XCTAssertEqualObjects(input0.mf_urlEncodeOnce, output0);
    XCTAssertEqualObjects(output0.mf_urlEncodeOnce, output0);
    
    NSString *input1 = @"https://github.com/Tinghui/Objective-C-Style-Guide#初始化方法";
    NSString *output1 = @"https://github.com/Tinghui/Objective-C-Style-Guide#%E5%88%9D%E5%A7%8B%E5%8C%96%E6%96%B9%E6%B3%95";
    XCTAssertEqualObjects(input1.mf_urlEncodeOnce, output1);
    XCTAssertEqualObjects(output1.mf_urlEncodeOnce, output1);
    
    NSString *input2 = @"http://mp.weixin.qq.com/s?__biz=MjM5NTIyNTUyMQ==#wechat_redirect";
    NSString *output2 = @"http://mp.weixin.qq.com/s?__biz=MjM5NTIyNTUyMQ%3D%3D#wechat_redirect";
    XCTAssertEqualObjects(input2.mf_urlEncodeOnce, output2);
    
    NSString *input3 = @"http://www.cnblogs.com?next=http://www.cnblogs.com/season-huang/";
    NSString *output3 = @"http://www.cnblogs.com?next=http%3A%2F%2Fwww.cnblogs.com%2Fseason-huang%2F";
    XCTAssertEqualObjects(input3.mf_urlEncodeOnce, output3);
    
    NSString *input4 = @"http://oss.joobank.com/cs/temp/2017062411560915044761918680.pdf?Expires=4651876571&OSSAccessKeyId=LTAIwBbxNo07zuzy&Signature=H6mXLN%2F575EsUDLVAaQ0F88R%2B1o%3D";
    XCTAssertEqualObjects(input4.mf_urlEncodeOnce, input4);
}

- (void)testSimpleQueryString {
    NSString *query = @"?foo=bar&bar=foo#end";
    NSDictionary *result = @{@"foo": @"bar", @"bar": @"foo"};
    XCTAssertEqualObjects(query.mf_urlQueryParameters, result);
}

- (void)testAppendQuery {
    NSString *query1 = @"?foo=bar";
    NSString *query2 = @"foo=bar";
    NSString *URLString1 = @"http://apple.com?";
    NSString *URLString2 = @"http://apple.com";
    NSString *result = @"http://apple.com?foo=bar";
    XCTAssertEqualObjects([URLString1 mf_stringByAppendingURLQuery:query1], result);
    XCTAssertEqualObjects([URLString1 mf_stringByAppendingURLQuery:query2], result);
    XCTAssertEqualObjects([URLString2 mf_stringByAppendingURLQuery:query1], result);
    XCTAssertEqualObjects([URLString2 mf_stringByAppendingURLQuery:query2], result);
}

- (void)testQueryStringCreating {
    NSString *urlString = @"http://apple.com";
    NSString *result = @"http://apple.com?foo=bar";
    XCTAssertEqualObjects([urlString mf_stringByAppendingURLQuery:[NSString mf_queryStringForParameters:@{@"foo": @"bar"}]], result);
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
    XCTAssertEqualObjects(urlString.mf_urlQueryParameters, result);
}

- (void)testQueryStringReplaceing {
    NSString *urlString = @"http://mp.weixin.qq.com/s?__biz=MjM5NTIyNTUyMQ==&mid=2709544856&idx=1&sn=6633c10e2d2d90f989aefbe9f62d6667&scene=1&srcid=0526eD4Ow7h4JtUTuRR3VpJI&from=groupmessage&isappinstalled=0#wechat_redirect";
    NSString *reulst = @"http://mp.weixin.qq.com/s?foo=bar#wechat_redirect";
    XCTAssertEqualObjects([urlString mf_stringByReplacingURLQueryWithQuery:@"foo=bar"], reulst);
}

- (void)testFragmentString {
    NSString *urlString = @"http://mp.weixin.qq.com/s?__biz=MjM5NTIyNTUyMQ==&mid=2709544856&idx=1&sn=6633c10e2d2d90f989aefbe9f62d6667&scene=1&srcid=0526eD4Ow7h4JtUTuRR3VpJI&from=groupmessage&isappinstalled=0#wechat_redirect";
    NSString *result = @"http://mp.weixin.qq.com/s?__biz=MjM5NTIyNTUyMQ==&mid=2709544856&idx=1&sn=6633c10e2d2d90f989aefbe9f62d6667&scene=1&srcid=0526eD4Ow7h4JtUTuRR3VpJI&from=groupmessage&isappinstalled=0";
    XCTAssertEqualObjects(urlString.mf_urlFragmentString, @"wechat_redirect");
    XCTAssertEqualObjects([urlString mf_deleteURLFragmentString], result);
}



@end



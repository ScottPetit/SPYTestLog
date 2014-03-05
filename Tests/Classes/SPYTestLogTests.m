//
//  SPYTestLogTests.m
//  SPYTestLogTests
//
//  Created by Scott Petit on 3/3/14.
//  Copyright (c) 2014 Scott Petit. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface SPYTestLogTests : XCTestCase

@end

@implementation SPYTestLogTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testPassingExample
{
    XCTAssertTrue(YES, @"");
}

- (void)testAnotherExample
{
    NSString *a = @"a";
    NSString *b = @"a";
    
    XCTAssertEqualObjects(a, nil, @"");
}

@end

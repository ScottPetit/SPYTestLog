//
//  SPYTestLog.m
//  SPYTestLog
//
//  Created by Scott Petit on 3/3/14.
//  Copyright (c) 2014 Scott Petit. All rights reserved.
//

#import "SPYTestLog.h"

#define SPY_XCODE_COLORS "XcodeColors"
#define SPY_XCODE_COLORS_ESCAPE @"\033["
#define SPY_XCODE_COLORS_RESET     SPY_XCODE_COLORS_ESCAPE @";"   // Clear any foreground or background color

@interface SPYTestLog ()
{
    BOOL _testCaseDidStop;
    BOOL _testCaseDidSucceed;
    BOOL _testCaseDidFail;
}

- (BOOL)hasXcodeColors;

@end

@implementation SPYTestLog

#pragma mark - XCTestObserver

- (void)testCaseDidStop:(XCTestRun *)testRun
{
    _testCaseDidStop = YES;
    _testCaseDidSucceed = [testRun hasSucceeded];
    
    [super testCaseDidStop:testRun];
    
    _testCaseDidStop = NO;
}

- (void)testCaseDidFail:(XCTestRun *)testRun withDescription:(NSString *)description inFile:(NSString *)filePath atLine:(NSUInteger)lineNumber
{
    _testCaseDidFail = YES;
    [super testCaseDidFail:testRun withDescription:description inFile:filePath atLine:lineNumber];
    _testCaseDidFail = NO;
}

#pragma mark - XCTestLog

- (void)testLogWithFormat:(NSString *)format arguments:(va_list)arguments
{
    if (_testCaseDidStop && _testCaseDidSucceed && [self hasXcodeColors])
    {
        format = [NSString stringWithFormat:@"%@%@%@ %@", SPY_XCODE_COLORS_ESCAPE, [self testCasePassedColor], format, SPY_XCODE_COLORS_RESET];
    }
    else if (_testCaseDidStop && !_testCaseDidSucceed && [self hasXcodeColors])
    {
        format = [NSString stringWithFormat:@"%@%@%@ %@", SPY_XCODE_COLORS_ESCAPE, [self testCaseFailedColor], format, SPY_XCODE_COLORS_RESET];
    }
    else if (_testCaseDidFail && [self hasXcodeColors])
    {
        format = [NSString stringWithFormat:@"%@%@%@ %@", SPY_XCODE_COLORS_ESCAPE, [self testCaseFailedColor], format, SPY_XCODE_COLORS_RESET];
    }
    
    [super testLogWithFormat:format arguments:arguments];
}

#pragma mark - Public

- (NSString *)testCasePassedColor
{
    return @"fg127,175,27;";
}

- (NSString *)testCaseFailedColor
{
    return @"fg230,45,27;";
}

#pragma mark - Private

- (BOOL)hasXcodeColors
{
    char *xcode_colors = getenv(SPY_XCODE_COLORS);
    return (xcode_colors && (strcmp(xcode_colors, "YES") == 0));
}

@end

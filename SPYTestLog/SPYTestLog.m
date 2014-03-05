//
//  SPYTestLog.m
//  SPYTestLog
//
//  Created by Scott Petit on 3/3/14.
//  Copyright (c) 2014 Scott Petit. All rights reserved.
//

#import "SPYTestLog.h"

static char * const XcodeColors = "XcodeColors";
static NSString * const XcodeColorsEscape = @"\033[";
static NSString * const XcodeColorsReset = @"\033[;";

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
        format = [NSString stringWithFormat:@"%@%@ %@ %@", XcodeColorsEscape, [self testCasePassedColor], format, XcodeColorsReset];
    }
    else if (_testCaseDidStop && !_testCaseDidSucceed && [self hasXcodeColors])
    {
        format = [NSString stringWithFormat:@"%@%@%@ %@", XcodeColorsEscape, [self testCaseFailedColor], format, XcodeColorsReset];
    }
    else if (_testCaseDidFail && [self hasXcodeColors])
    {
        format = [NSString stringWithFormat:@"%@%@ %@ %@", XcodeColorsEscape, [self testCaseFailedColor], format, XcodeColorsReset];
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
    char *xcode_colors = getenv(XcodeColors);
    return (xcode_colors && (strcmp(xcode_colors, "YES") == 0));
}

@end

//
//  SPYTestLog.h
//  SPYTestLog
//
//  Created by Scott Petit on 3/3/14.
//  Copyright (c) 2014 Scott Petit. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface SPYTestLog : XCTestLog

- (NSString *)testCasePassedColor;
- (NSString *)testCaseFailedColor;

@end

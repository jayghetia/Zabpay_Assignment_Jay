//
//  CoreDataUITests.m
//  CoreDataUITests
//
//  Created by Jay on 10/5/17.
//  Copyright © 2017 Jay. All rights reserved.

#import <XCTest/XCTest.h>

@interface CoreDataUITests : XCTestCase

@end

@implementation CoreDataUITests

- (void)setUp {
    [super setUp];
    
    self.continueAfterFailure = NO;
    [[[XCUIApplication alloc] init] launch];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testExample {
}

@end

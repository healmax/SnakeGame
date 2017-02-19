//
//  SnakeGameTests.m
//  SnakeGameTests
//
//  Created by healmax healmax on 2017/2/14.
//  Copyright © 2017年 qnap. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "QWorldSpace.h"
#import "QSnake.h"

@interface SnakeGameTests : XCTestCase

@end

@implementation SnakeGameTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)testHeadhitBody {
    QWorldSize worldSize = QMakeWorldSize(24, 24);
    QSnake *snake = [[QSnake alloc] initWithLenght:6 worldSize: worldSize];
    [snake changeDirection:QSnakeDirectionUp];
    [snake move];
    [snake changeDirection:QSnakeDirectionRight];
    [snake move];
    [snake changeDirection:QSnakeDirectionDown];
    [snake move];
    XCTAssertEqual([snake isHeadHitBody], YES, @"head hit body");
}

@end

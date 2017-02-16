//
//  QWorldSpace.h
//  SnakeGame
//
//  Created by healmax healmax on 2017/2/15.
//  Copyright © 2017年 qnap. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SnakeGameDefine.h"
#import <ReactiveObjC/ReactiveObjC.h>
//#import "QSnake.h"
@class QSnake;

QWorldSize QMakeWorldSize(NSUInteger width, NSUInteger height);

@interface QWorldSpace : NSObject

@property (nonatomic, assign) BOOL isStarting;
@property (nonatomic, strong, readonly) QSnake *snake;
@property (nonatomic, assign, readonly) QWorldSize worldSize;
@property (nonatomic, strong, readonly) NSValue *applePoint;
@property (nonatomic, strong) RACCommand *startCommand;

@property (nonatomic, copy) void(^refreshView)();

- (instancetype)initWithWorldSize:(QWorldSize)worldSize;
//- (void)startGame;

@end

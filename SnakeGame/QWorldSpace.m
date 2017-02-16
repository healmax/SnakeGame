//
//  QWorldSpace.m
//  SnakeGame
//
//  Created by healmax healmax on 2017/2/15.
//  Copyright © 2017年 qnap. All rights reserved.
//

#import "QWorldSpace.h"
#import "QSnake.h"
#import <ReactiveObjC/ReactiveObjC.h>

QWorldSize QMakeWorldSize(NSUInteger width, NSUInteger height) {
    QWorldSize worldSize;
    worldSize.height = height;
    worldSize.width = width;
    return worldSize;
}

@interface QWorldSpace()<QSnakeDelegate>

@property (nonatomic, strong, readwrite) QSnake *snake;
@property (nonatomic, assign, readwrite) QWorldSize worldSize;
@property (nonatomic, strong, readwrite) NSValue *applePoint;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation QWorldSpace

- (instancetype)initWithWorldSize:(QWorldSize)worldSize {
    if (self = [super init]) {
        @weakify(self)
        self.worldSize = worldSize;
        self.startCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self);
            return [self startGameSignal];
        }];
    }
    
    return self;
}

- (RACSignal *)startGameSignal {
    @weakify(self)
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        @strongify(self);
        if (self.timer) {
            return nil;
        }
        [self makeNewApplePoint];
        self.snake = [[QSnake alloc] initWithLenght:2 worldSize:self.worldSize];
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.25 target:self selector:@selector(snakeRunLoop) userInfo:nil repeats:YES];
        self.isStarting = YES;
        
        [subscriber sendCompleted];
        return nil;
    }];
}

- (void)endGame {
    [self.timer invalidate];
    self.timer = nil;
    self.isStarting = NO;
}

- (void)snakeRunLoop {
    [self.snake move];
    if ([self.snake isHeadHitBody] || [self isHeadHitBorder:self.snake]) {
        [self endGame];
    }
    QSnakePoint snakeHeadPoint = [[self.snake.snakePositions firstObject] snakePointValue];
    QSnakePoint applePoint = [self.applePoint snakePointValue];
    if (applePoint.x == snakeHeadPoint.x && applePoint.y == snakeHeadPoint.y) {
        [self.snake increaseSnakeLenght:2];
        [self makeNewApplePoint];
    }
    if (self.refreshView) self.refreshView();
}

- (void)makeNewApplePoint {
    NSInteger applePointX = 0;
    NSInteger applePointY = 0;
    while (1) {
        applePointX = arc4random() % self.worldSize.width;
        applePointY = arc4random() % self.worldSize.height;
        BOOL isAppleOnSnakeBody = NO;
        for (NSInteger index=0 ; index<self.snake.snakePositions.count ; index++) {
            QSnakePoint snakePoint = [self.snake getSnakePointValueByIndex:index];
            if (snakePoint.x == applePointX && snakePoint.y == applePointY) {
                isAppleOnSnakeBody = YES;
                break;
            }
        }
        
        if (!isAppleOnSnakeBody) {
            break;
        }
    }
    self.applePoint = [NSValue initWithSnakPoint:QMakeSnakePoint(applePointX, applePointY)];
}

#pragma QSnakeDelegate<NSObject>

- (BOOL)isHeadHitBorder:(QSnake *)snake {
    QSnakePoint headPoint = [snake getSnakePointValueByIndex:0];
    if (headPoint.x <0 || headPoint.x>=self.worldSize.width || headPoint.y<0 || headPoint.y>=self.worldSize.height) {
        return YES;
    }
    
    return NO;
}

@end

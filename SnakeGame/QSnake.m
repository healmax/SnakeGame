//
//  QSnake.m
//  SnakeGame
//
//  Created by healmax healmax on 2017/2/14.
//  Copyright © 2017年 qnap. All rights reserved.
//

#import "QSnake.h"
#import "QWorldSpace.h"

QSnakePoint QMakeSnakePoint(NSUInteger x, NSUInteger y) {
    QSnakePoint point;
    point.x = x;
    point.y = y;
    return point;
}

@implementation NSValue (QSnakePoint)

+(NSValue *)initWithSnakPoint:(QSnakePoint)point {
    return	[NSValue valueWithBytes:&point objCType:@encode(QSnakePoint)];
}

- (QSnakePoint)snakePointValue
{
    if (strcmp([self objCType], @encode(QSnakePoint)) == 0) {
        QSnakePoint origin;
        [self getValue:&origin];
        return origin;
    }
    return QMakeSnakePoint(0, 0);
}

@end

@interface QSnake()

@property (nonatomic, assign) QSnakeDirection direction;

@end

@implementation QSnake

- (instancetype)initWithLenght:(NSUInteger)lenght worldSize:(QWorldSize)worldSize {
    if (self = [super init]) {
        self.snakePositions = [NSMutableArray new];
        self.direction = QSnakeDirectionLeft;
        
        NSInteger snakeHeadPositionX = worldSize.width/2;
        NSInteger snakeHeadPositionY = worldSize.height/2;
        
        for (NSUInteger index=0 ; index<lenght; index++) {
            QSnakePoint snakePoint = QMakeSnakePoint(snakeHeadPositionX+index,snakeHeadPositionY);
            [self.snakePositions addObject:[NSValue initWithSnakPoint:snakePoint]];
        }
        
    }
    
    return self;
}

- (void)move {
    [self.snakePositions removeLastObject];
    QSnakePoint headPoint = [[self.snakePositions firstObject] snakePointValue];
    NSInteger nextHeadPointX = headPoint.x;
    NSInteger nextHeadPointY = headPoint.y;
    switch (self.direction) {
        case QSnakeDirectionUp:
            nextHeadPointY--;
            break;
        case QSnakeDirectionLeft:
            nextHeadPointX--;
            break;
        case QSnakeDirectionDown:
            nextHeadPointY++;
            break;
        case QSnakeDirectionRight:
            nextHeadPointX++;
            break;
        default:
            break;
    }
    QSnakePoint nextHeadPoint = QMakeSnakePoint(nextHeadPointX, nextHeadPointY);
    [self.snakePositions insertObject:[NSValue initWithSnakPoint:nextHeadPoint]atIndex:0];
}

- (void)changeDirection:(QSnakeDirection)direction {
    if (self.direction == QSnakeDirectionUp || self.direction == QSnakeDirectionDown) {
        if (direction == QSnakeDirectionUp || direction == QSnakeDirectionDown) {
            return;
        }
    }
    
    if (self.direction == QSnakeDirectionLeft || self.direction == QSnakeDirectionRight) {
        if (direction == QSnakeDirectionLeft || direction == QSnakeDirectionRight) {
            return;
        }
    }
    
    self.direction = direction;
}

- (BOOL)isHeadHitBody {
    QSnakePoint headPoint = [[self.snakePositions firstObject] snakePointValue];
    QSnakePoint bodyPoint;
    for (NSInteger index=1; index<self.snakePositions.count; index++) {
        bodyPoint = [self.snakePositions[index] snakePointValue];
        if (bodyPoint.x == headPoint.x && bodyPoint.y == headPoint.y) return YES;
    }
    
    return NO;
}

- (void)increaseSnakeLenght:(NSUInteger)length {
    QSnakePoint lastBody = [[self.snakePositions lastObject] snakePointValue];
    for (NSUInteger index=0; index<length; index++) {
        [self.snakePositions addObject:[NSValue initWithSnakPoint:lastBody]];
    }
}

- (QSnakePoint)getSnakePointValueByIndex:(NSInteger)index {
    return [self.snakePositions[index] snakePointValue];
}

@end

//
//  QSnake.h
//  SnakeGame
//
//  Created by healmax healmax on 2017/2/14.
//  Copyright © 2017年 qnap. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SnakeGameDefine.h"

//typedef struct {
//    NSInteger x;
//    NSInteger y;
//} QSnakePoint;

QSnakePoint QMakeSnakePoint(NSUInteger x, NSUInteger y);

@interface NSValue (ZBSnakePoint)
+ (NSValue *)initWithSnakPoint:(QSnakePoint)point;
- (QSnakePoint)snakePointValue;
@end

@class QSnake;
@protocol  QSnakeDelegate<NSObject>

@required
- (BOOL)isHeadHitBorder:(QSnake *)snake;

@end


@interface QSnake : NSObject

#pragma mark porperty
//第一個index 0為蛇頭
@property (nonatomic, strong) NSMutableArray *snakePositions;
//@property (nonatomic, weak) id<QSnakeDelegate> snakeDelegat;


#pragma mark method
//+ (NSValue *)initWithSnakePoint:(QSnakePoint)snakePint;

- (instancetype)initWithLenght:(NSUInteger)lenght worldSize:(QWorldSize)worldSize;
- (QSnakePoint)getSnakePointValueByIndex:(NSInteger)index;
- (void)move;
- (void)changeDirection:(QSnakeDirection)direction;
- (BOOL)isHeadHitBody;
- (void)increaseSnakeLenght:(NSUInteger)length;
@end






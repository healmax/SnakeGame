//
//  SnakeGameDefine.h
//  SnakeGame
//
//  Created by healmax healmax on 2017/2/15.
//  Copyright © 2017年 qnap. All rights reserved.
//

#ifndef SnakeGameDefine_h
#define SnakeGameDefine_h

typedef struct {
    NSUInteger width;
    NSUInteger height;
} QWorldSize;

typedef struct {
    NSInteger x;
    NSInteger y;
} QSnakePoint;

typedef NS_ENUM(NSInteger, QSnakeDirection){
    QSnakeDirectionUp,
    QSnakeDirectionLeft,
    QSnakeDirectionDown,
    QSnakeDirectionRight
};

#endif /* SnakeGameDefine_h */

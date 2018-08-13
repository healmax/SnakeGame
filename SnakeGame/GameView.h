//
//  GameView.h
//  SnakeGame
//
//  Created by healmax healmax on 2017/2/15.
//  Copyright © 2017年 qnap. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QWorldSpace.h"

@class GameView;
@protocol GameViewDelegate <NSObject>

- (void)didStartGame:(GameView *)view;
- (void)didEndGame:(GameView *)view;

@end

@interface GameView : UIView

@property (weak, nonatomic) id <GameViewDelegate> delegate;
@property (nonatomic, strong) QWorldSpace *worldSpace;

- (void)startGame;
- (void)changeDirection:(QSnakeDirection)direction;

@end

//
//  GameView.h
//  SnakeGame
//
//  Created by healmax healmax on 2017/2/15.
//  Copyright © 2017年 qnap. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QWorldSpace.h"

//@protocol GameViewDelegate <NSObject>
//
//- ()
//
//@end

@interface GameView : UIView

@property (nonatomic, strong) QWorldSpace *worldSpace;

- (void)changeDirection:(QSnakeDirection)direction;

@end

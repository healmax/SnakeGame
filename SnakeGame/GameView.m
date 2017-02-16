//
//  GameView.m
//  SnakeGame
//
//  Created by healmax healmax on 2017/2/15.
//  Copyright © 2017年 qnap. All rights reserved.
//

#import "GameView.h"
#import "QSnake.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import <PureLayout/PureLayout.h>

@interface GameView()

@property (nonatomic, strong) UIButton *startButton;

@end

@implementation GameView

-(void)awakeFromNib {
    [super awakeFromNib];
    [self initGesture];
    [self initWorldSpace];
    [self initStartButton];
    [self initBinding];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
 */
- (void)drawRect:(CGRect)rect {
    if (!self.worldSpace) return;
    
    QWorldSize wordSize = self.worldSpace.worldSize;
    if (wordSize.height ==0 || wordSize.width==0) return;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGFloat w = self.bounds.size.width/self.worldSpace.worldSize.width;
    CGFloat h = self.bounds.size.height/self.worldSpace.worldSize.height;
    
    if (self.worldSpace.snake) {
        [[UIColor blackColor] set];
        for (NSInteger index = 0 ; index<self.worldSpace.snake.snakePositions.count ; index++) {
            QSnakePoint snakePosition = [self.worldSpace.snake getSnakePointValueByIndex:index];
            CGRect rect = CGRectMake(snakePosition.x*w, snakePosition.y*h, w, h);
            CGContextFillRect(context, rect);
        }
    }
    
    if (self.worldSpace.applePoint) {
        [[UIColor redColor] set];
        QSnakePoint applePoint = [self.worldSpace.applePoint snakePointValue];
        CGRect rect = CGRectMake(applePoint.x*w, applePoint.y*h, w, h);
        UIImage *image = [UIImage imageNamed:@"apple"];
        [image drawInRect:rect];
    }
    
    self.layer.borderColor = [UIColor redColor].CGColor;
}

-(void)setWorldSpace:(QWorldSpace *)worldSpace {
    __block __weak GameView *weakSefl = self;
    _worldSpace = worldSpace;
    _worldSpace.refreshView =^() {
        [weakSefl setNeedsDisplay];
    };
}

- (void)initBinding {
    @weakify(self)
    [RACObserve(self.worldSpace, isStarting) subscribeNext:^(NSNumber *isStarting) {
        @strongify(self)
        if (self.startButton) {
            isStarting.boolValue ? [self.startButton setHidden:YES] : [self.startButton setHidden:NO];
        }
    }];
}

- (void)initWorldSpace {
    self.worldSpace = [[QWorldSpace alloc] initWithWorldSize:QMakeWorldSize(24,24)];
}

- (void)initStartButton {
    self.startButton = [[UIButton alloc] init];
    [self.startButton setTitle:@"start game" forState:UIControlStateNormal];
    [self.startButton setBackgroundColor:[UIColor blueColor]];
    [self.startButton setRac_command:self.worldSpace.startCommand];
    [self addSubview:self.startButton];
    [self.startButton autoCenterInSuperview];
}

- (void)initGesture {
    [self addGestureWithDirection:UISwipeGestureRecognizerDirectionUp];
    [self addGestureWithDirection:UISwipeGestureRecognizerDirectionLeft];
    [self addGestureWithDirection:UISwipeGestureRecognizerDirectionDown];
    [self addGestureWithDirection:UISwipeGestureRecognizerDirectionRight];
}

- (void)addGestureWithDirection:(UISwipeGestureRecognizerDirection)direction {
    UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipMethod:)];
    recognizer.direction = direction;
    [self addGestureRecognizer:recognizer];
}

- (void)swipMethod:(UISwipeGestureRecognizer *)recognizer {
    switch (recognizer.direction) {
        case UISwipeGestureRecognizerDirectionUp: {
                [self changeDirection:QSnakeDirectionUp];
            }
            break;
        case UISwipeGestureRecognizerDirectionLeft:{
                [self changeDirection:QSnakeDirectionLeft];
            }
            break;
        case UISwipeGestureRecognizerDirectionDown:{
                [self changeDirection:QSnakeDirectionDown];
            }
            break;
        case UISwipeGestureRecognizerDirectionRight:{
                [self changeDirection:QSnakeDirectionRight];
            }
            break;
        default:
            break;
    }
}

- (void)changeDirection:(QSnakeDirection)direction {
     [self.worldSpace.snake changeDirection:direction];
}

@end

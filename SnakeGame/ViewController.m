//
//  ViewController.m
//  SnakeGame
//
//  Created by healmax healmax on 2017/2/14.
//  Copyright © 2017年 qnap. All rights reserved.
//

#import "ViewController.h"
#import "QWorldSpace.h"
#import "GameView.h"

@interface ViewController ()

//@property (nonatomic, strong) QWorldSpace *worldSpace;
@property (weak, nonatomic) IBOutlet GameView *gmaeView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)upButtonOnClick:(id)sender {
    [self.gmaeView changeDirection:QSnakeDirectionUp];
}

- (IBAction)leftButtonOnClick:(id)sender {
    [self.gmaeView changeDirection:QSnakeDirectionLeft];
}

- (IBAction)downButtonOnClick:(id)sender {
    [self.gmaeView changeDirection:QSnakeDirectionDown];
}

- (IBAction)rightleftButtonOnClick:(id)sender {
    [self.gmaeView changeDirection:QSnakeDirectionRight];
}

@end

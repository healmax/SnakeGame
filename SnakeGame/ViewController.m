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

@interface ViewController ()<GameViewDelegate>

//@property (nonatomic, strong) QWorldSpace *worldSpace;
@property (weak, nonatomic) IBOutlet GameView *gameView;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UILabel *startGameLabel;
@property (weak, nonatomic) IBOutlet UILabel *maxScoreLabel;
@property (assign, nonatomic) NSInteger score;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self commonInit];
}

- (void)commonInit {
    self.score = 0;
    self.gameView.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scoreChanged) name:QWorldSpaceEatedApple object:nil];
    self.scoreLabel.text = NSLocalizedString(@"Score", nil);
    self.startGameLabel.text = NSLocalizedString(@"StartGame", nil);
    self.maxScoreLabel.text = NSLocalizedString(@"MaxScore", nil);
}

- (void)scoreChanged {
    self.score ++;
    self.scoreLabel.text = @(self.score).stringValue;
}

- (IBAction)starGame:(id)sender {
    [self.gameView startGame];
    self.startGameLabel.text = NSLocalizedString(@"Restart", nil);
    self.containerView.hidden = YES;
}

#pragma mark - GameViewDelegate

- (void)didStartGame:(GameView *)view {
    self.score = 0;
    self.scoreLabel.text = @(self.score).stringValue;
    self.containerView.hidden = YES;
}

- (void)didEndGame:(GameView *)view {
    self.containerView.hidden = NO;
}

@end

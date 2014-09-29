//
//  ViewController.m
//  NewTicTacToe
//
//  Created by Albert Saucedo on 9/24/14.
//  Copyright (c) 2014 Albert Saucedo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIGestureRecognizerDelegate>
@end

@implementation ViewController
@synthesize timerLabel;

- (void)viewDidLoad
{
    [super viewDidLoad];

    int intTurn = arc4random()%2;

    if (intTurn == 1) {
        self.draggedTileLabel.text = @"X";

    } else {
        self.draggedTileLabel.text = @"O";
    }

    [self countDownTimers];
    self.draggedTileLabel.hidden = YES;

}

-(void)handelCountdownTimerTick{

    self.remainingCountTicks--;

    if (self.remainingCountTicks == 5) {
        self.countDownLabel.text = @"Ready";
    } else if (self.remainingCountTicks == 4){
        self.countDownLabel.text = @"Ready.";
    } else if (self.remainingCountTicks == 3){
        self.countDownLabel.text = @"Ready..";
    }else if (self.remainingCountTicks == 2){
        self.countDownLabel.text = @"Set";
    } else if (self.remainingCountTicks == 1){
        self.countDownLabel.text = @"Go!";
    } else {
        self.draggedTileLabel.hidden = NO;
        self.countDownLabel.hidden = YES;
    }
}

-(void)handelTimerTick{
    self.remainingTicks--;
    NSString *timeString = [[NSString alloc] initWithFormat:@":0%d", self.remainingTicks];
    self.timerLabel.text = timeString;

    [self switchPlayer];
}

- (IBAction)onDrag:(UIPanGestureRecognizer *)panGestureRec point:(CGPoint)point {

    if(panGestureRec.state == UIGestureRecognizerStateEnded)
    {
        NSLog(@"Finger is off");
        [self resetDraggingLabel];
        [self countDownTimers];
        [self switchPlayer];
        [self.timer invalidate];

        if (CGRectContainsPoint(self.labelEight.frame, point)) {

            if ([self.draggedTileLabel.text isEqualToString: @"X"]) {
                self.labelEight.text = @"X";
                self.labelEight.textColor =  [UIColor colorWithRed:1 green:0.18 blue:0.33 alpha:1];
            } else {
                self.labelEight.text = @"O";
                self.labelEight.textColor = [UIColor colorWithRed:0.29 green:0.4 blue:0.62 alpha:1];
            }
            if ([self.labelEight.text isEqualToString:@"X"]){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Player X WON!"
                                                                message:nil
                                                               delegate:self
                                                      cancelButtonTitle:@"New Game"
                                                      otherButtonTitles:nil, nil];
                [alert show];
                
                [self.timer invalidate];
            }
        }
    }
    
    self.draggedTileLabel = (UILabel *)panGestureRec.view;
    
    point = [panGestureRec translationInView:self.draggedTileLabel];
    
    self.draggedTileLabel.center = CGPointMake(self.draggedTileLabel.center.x + point.x, self.draggedTileLabel.center.y + point.y);
    [panGestureRec setTranslation:CGPointZero inView:self.draggedTileLabel];
}

#pragma mark Helper Methods

- (void)resetDraggingLabel {
    CGRect resetDraggingLabel = [self.draggedTileLabel frame];
    resetDraggingLabel.origin.y = 416;
    resetDraggingLabel.origin.x = 125;
    self.draggedTileLabel.frame = resetDraggingLabel;
}

- (void)switchPlayer {
    if (self.remainingTicks == 0) {
        self.remainingTicks = 5;

        [self resetDraggingLabel];

        if ([self.draggedTileLabel.text isEqualToString:@"X"]) {
            self.draggedTileLabel.text = @"O";
            self.draggedTileLabel.textColor = [UIColor colorWithRed:0.29 green:0.4 blue:0.62 alpha:1];
        } else {
            self.draggedTileLabel.text = @"X";
            self.draggedTileLabel.textColor =  [UIColor colorWithRed:1 green:0.18 blue:0.33 alpha:1];
        }
    }
}

- (void)countDownTimers
{
    self.remainingTicks = 5;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:.75
                                                  target:self
                                                selector:@selector(handelTimerTick)
                                                userInfo:nil
                                                 repeats:YES];
    self.remainingCountTicks = 5;
    self.countDownTimerTick = [NSTimer scheduledTimerWithTimeInterval:.75
                                                               target:self
                                                             selector:@selector(handelCountdownTimerTick)
                                                             userInfo:nil
                                                              repeats:YES];
}

@end
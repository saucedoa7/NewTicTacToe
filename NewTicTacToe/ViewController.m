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

- (IBAction)onDrag:(UIPanGestureRecognizer *)panGestureRec point:(CGPoint)point {

    self.draggedTileLabel = (UILabel *)panGestureRec.view;

    point = [panGestureRec translationInView:self.draggedTileLabel];

    self.draggedTileLabel.center = CGPointMake(self.draggedTileLabel.center.x + point.x, self.draggedTileLabel.center.y + point.y);
    [panGestureRec setTranslation:CGPointZero inView:self.draggedTileLabel];

    point.x = point.x + self.draggedTileLabel.center.x;
    point.y += self.draggedTileLabel.center.y;

    if(panGestureRec.state == UIGestureRecognizerStateEnded)
    {
        NSLog(@"Finger is off");
        [self mainLabelsArray];

        for (UILabel *label in self.labelsArray) {

            NSLog(@"LABELS %@", label.text);

            if (CGRectContainsPoint(label.frame, point)) {

                NSLog(@"Path hits frame");

                if ([label.text isEqualToString:@"X"] || [label.text isEqualToString:@"O"]) {
                    if ([self.draggedTileLabel.text isEqualToString: @"X"]) {
                        self.draggedTileLabel.text = @"X";
                        self.draggedTileLabel.textColor =  [UIColor colorWithRed:1 green:0.18 blue:0.33 alpha:1];
                    } else if ([self.draggedTileLabel.text isEqualToString:@"O"]) {
                        self.draggedTileLabel.text = @"O";
                        self.draggedTileLabel.textColor = [UIColor colorWithRed:0.29 green:0.4 blue:0.62 alpha:1];
                    }
                    [self resetDraggingLabel];
                } else {
                    if ([self.draggedTileLabel.text isEqualToString: @"X"]) {
                        label.text = @"X";
                        label.textColor =  [UIColor colorWithRed:1 green:0.18 blue:0.33 alpha:1];
                    } else if ([self.draggedTileLabel.text isEqualToString:@"O"]) {
                        label.text = @"O";
                        label.textColor = [UIColor colorWithRed:0.29 green:0.4 blue:0.62 alpha:1];
                    }

                    [self countDownTimers];
                    [self.timer invalidate];
                    [self switchPlayer];

                }
                if (([self.labelOne.text isEqualToString:@"X"] &&
                     [self.labelTwo.text isEqualToString:@"X"] &&
                     [self.labelThree.text isEqualToString: @"X"]) ||
                    ([self.labelFour.text isEqualToString:@"X"] &&
                     [self.labelFive.text isEqualToString:@"X"] &&
                     [self.labelSix.text isEqualToString: @"X"]) ||
                    ([self.labelSeven.text isEqualToString:@"X"] &&
                     [self.labelEight.text isEqualToString:@"X"] &&
                     [self.labelNine.text isEqualToString: @"X"]) ||
                    ([self.labelThree.text isEqualToString:@"X"] &&
                     [self.labelSix.text isEqualToString:@"X"] &&
                     [self.labelNine.text isEqualToString: @"X"]) ||
                    ([self.labelOne.text isEqualToString:@"X"] &&
                     [self.labelFour.text isEqualToString:@"X"] &&
                     [self.labelSeven.text isEqualToString: @"X"]) ||
                    ([self.labelTwo.text isEqualToString:@"X"] &&
                     [self.labelFive.text isEqualToString:@"X"] &&
                     [self.labelEight.text isEqualToString: @"X"]) ||
                    ([self.labelOne.text isEqualToString:@"X"] &&
                     [self.labelFive.text isEqualToString:@"X"] &&
                     [self.labelNine.text isEqualToString: @"X"]) ||
                    ([self.labelThree.text isEqualToString:@"X"] &&
                     [self.labelEight.text isEqualToString:@"X"] &&
                     [self.labelFive.text isEqualToString: @"X"])) {
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Player X WON!"
                                                                        message:nil
                                                                       delegate:self
                                                              cancelButtonTitle:@"New Game"
                                                              otherButtonTitles:nil, nil];
                        [alert show];

                        [self.timer invalidate];
                    }

                if (([self.labelOne.text isEqualToString:@"O"] &&
                     [self.labelTwo.text isEqualToString:@"O"] &&
                     [self.labelThree.text isEqualToString: @"O"]) ||
                    ([self.labelFour.text isEqualToString:@"O"] &&
                     [self.labelFive.text isEqualToString:@"O"] &&
                     [self.labelSix.text isEqualToString: @"O"]) ||
                    ([self.labelSeven.text isEqualToString:@"O"] &&
                     [self.labelEight.text isEqualToString:@"O"] &&
                     [self.labelNine.text isEqualToString: @"O"]) ||
                    ([self.labelThree.text isEqualToString:@"O"] &&
                     [self.labelSix.text isEqualToString:@"O"] &&
                     [self.labelNine.text isEqualToString: @"0"]) ||
                    ([self.labelOne.text isEqualToString:@"O"] &&
                     [self.labelFour.text isEqualToString:@"O"] &&
                     [self.labelSeven.text isEqualToString: @"O"]) ||
                    ([self.labelTwo.text isEqualToString:@"O"] &&
                     [self.labelFive.text isEqualToString:@"O"] &&
                     [self.labelEight.text isEqualToString: @"O"]) ||
                    ([self.labelOne.text isEqualToString:@"O"] &&
                     [self.labelFive.text isEqualToString:@"O"] &&
                     [self.labelNine.text isEqualToString: @"O"]) ||
                    ([self.labelThree.text isEqualToString:@"O"] &&
                     [self.labelEight.text isEqualToString:@"O"] &&
                     [self.labelFive.text isEqualToString: @"O"])) {
                        [self.timer invalidate];
                        self.timer = nil;
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Player O WON!"
                                                                        message:nil
                                                                       delegate:self
                                                              cancelButtonTitle:@"New Game"
                                                              otherButtonTitles:@"Done", nil];

                        [alert show];
                    }
            }
            NSLog(@"LABELS 2 %@", label.text);
        }
    }
}

#pragma mark Helper Methods

-(void)mainLabelsArray{
    self.labelsArray = [NSArray arrayWithObjects:self.labelOne,
                        self.labelTwo,
                        self.labelThree,
                        self.labelFour,
                        self.labelFive,
                        self.labelSix,
                        self.labelSeven,
                        self.labelEight,
                        self.labelNine, nil];
}

- (void)resetDraggingLabel {
    CGRect resetDraggingLabel = [self.draggedTileLabel frame];
    resetDraggingLabel.origin.y = 416;
    resetDraggingLabel.origin.x = 125;
    self.draggedTileLabel.frame = resetDraggingLabel;
}

- (void)switchPlayer {

    [self resetDraggingLabel];

    if ([self.draggedTileLabel.text isEqualToString:@"X"]) {
        self.draggedTileLabel.text = @"O";
        self.draggedTileLabel.textColor = [UIColor colorWithRed:0.29 green:0.4 blue:0.62 alpha:1];
    } else {
        self.draggedTileLabel.text = @"X";
        self.draggedTileLabel.textColor =  [UIColor colorWithRed:1 green:0.18 blue:0.33 alpha:1];
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
    
    if (self.remainingTicks == 0) {
        self.remainingTicks = 5;
        [self switchPlayer];
    }
}
@end
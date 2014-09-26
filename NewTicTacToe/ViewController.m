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
    [self updateLabel];
    NSString *playerTurn;
    int intTurn = arc4random()%2;

    if (intTurn == 1) {
        playerTurn = @"X";
    } else {
        playerTurn = @"O";
    }

    if ([playerTurn isEqualToString:@"X"]) {
        self.draggedTileLabel.text = @"O";
    } else {
        self.draggedTileLabel.text = @"X";
    }
}

-(void)doCountDown:(id)sender{
    if (self.timer) {
        return;

        self.remainingTicks = 10;
        [self updateLabel];

        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.0
                                                      target:self
                                                    selector:@selector(handelTimerTick)
                                                    userInfo:nil
                                                     repeats:YES];
    }
}

-(void)handelTimerTick{
    self.remainingTicks--;
    [self updateLabel];

    if (self.remainingTicks <= 0) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

-(void)updateLabel{
    self.timerLabel.text = [[NSNumber numberWithInt:self.remainingTicks] stringValue];
}

- (IBAction)onDrag:(UIPanGestureRecognizer *)panGestureRec point:(CGPoint)point {

    point = [panGestureRec translationInView:self.view];

    self.draggedTileLabel.transform = CGAffineTransformMakeTranslation(point.x, point.y);
    point.x = point.x + self.draggedTileLabel.center.x;
    point.y += self.draggedTileLabel.center.y;


}

//if (CGRectContainsPoint(self.labelOne.frame, point)) {
//
//    if ([self.draggedTileLabel.text isEqualToString: @"X"]) {
//        self.labelOne.text = @"X";
//        self.labelOne.textColor =  [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1];
//    } else {
//        self.labelOne.text = @"O";
//        self.labelOne.textColor = [UIColor colorWithRed:0.9 green:0.32 blue:0.32 alpha:1];
//    }
//}
//
//if ([self.labelOne isEqual:@"X"]){
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Player X WON!"
//                                                    message:nil
//                                                   delegate:self
//                                          cancelButtonTitle:@"New Game"
//                                          otherButtonTitles:nil, nil];
//    [alert show];
//}

@end
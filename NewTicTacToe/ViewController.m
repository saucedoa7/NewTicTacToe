//
//  ViewController.m
//  NewTicTacToe
//
//  Created by Albert Saucedo on 9/24/14.
//  Copyright (c) 2014 Albert Saucedo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *labelOne;
@property (weak, nonatomic) IBOutlet UILabel *labelTwo;
@property (weak, nonatomic) IBOutlet UILabel *labelThree;
@property (weak, nonatomic) IBOutlet UILabel *labelFour;
@property (weak, nonatomic) IBOutlet UILabel *labelFive;
@property (weak, nonatomic) IBOutlet UILabel *labelSix;
@property (weak, nonatomic) IBOutlet UILabel *labelSeven;
@property (weak, nonatomic) IBOutlet UILabel *labelEight;
@property (weak, nonatomic) IBOutlet UILabel *labelNine;
@property (weak, nonatomic) IBOutlet UILabel *whichPlayer;
@property (weak, nonatomic) IBOutlet UILabel *draggedTileLabel;
@property NSMutableArray *labels;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

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

- (IBAction)onDrag:(UIPanGestureRecognizer *)panGestureRec point:(CGPoint)point {

    point = [panGestureRec translationInView:self.view];

    self.draggedTileLabel.transform = CGAffineTransformMakeTranslation(point.x, point.y);
    NSLog(@"x= %.0f, y=%.0f", self.draggedTileLabel.center.x, self.draggedTileLabel.center.y);

    point.x = point.x + self.draggedTileLabel.center.x;
    point.y += self.draggedTileLabel.center.y;

    if (CGRectContainsPoint(self.labelOne.frame, point)) {

        if ([self.draggedTileLabel.text isEqualToString: @"X"]) {
            self.labelOne.text = @"X";
            self.labelOne.textColor =  [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1];
        } else {
            self.labelOne.text = @"O";
            self.labelOne.textColor = [UIColor colorWithRed:0.9 green:0.32 blue:0.32 alpha:1];
        }
    }

    if ([self.labelOne isEqual:@"X"]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Player X WON!"
                                                        message:nil
                                                       delegate:self
                                              cancelButtonTitle:@"New Game"
                                              otherButtonTitles:nil, nil];
        [alert show];
    }
}
@end
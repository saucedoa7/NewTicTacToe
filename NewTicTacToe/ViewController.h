//
//  ViewController.h
//  NewTicTacToe
//
//  Created by Albert Saucedo on 9/24/14.
//  Copyright (c) 2014 Albert Saucedo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

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
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property NSArray *labelsArray;

@property NSString *playerTurn;
@property NSTimer *timer;
@property int remainingTicks;

@property int remainingCountTicks;
@property (weak, nonatomic) IBOutlet UILabel *countDownLabel;
@property NSTimer *countDownTimerTick;


-(IBAction)onDrag:(UIPanGestureRecognizer *)panGestureRec point:(CGPoint)point;
-(void)mainLabelsArray;
@end

//
//  ViewController.m
//  Multiply
//
//  Created by Philip Henson on 9/28/15.
//  Copyright © 2015 Phil Henson. All rights reserved.
//

#import "ViewController.h"
#import "CalculatorBrain.h"

@interface ViewController ()

@property CalculatorBrain *calculator;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.calculator = [[CalculatorBrain alloc] init];
}

-(BOOL)canBecomeFirstResponder {
    return YES;
}

- (void)viewDidAppear:(BOOL)animated {
    [self becomeFirstResponder];
}

-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (motion == UIEventSubtypeMotionShake) {
        [self clearNumber];
    }
}

-(void)clearNumber {
    self.textLabel.text=@"0";
    [self.calculator clearAll];
}

- (IBAction)numberButtonPressed:(UIButton *)sender {
    self.textLabel.text = [self.calculator didPressNumber:sender.titleLabel.text];
}

- (IBAction)clearButtonPressed:(UIButton *)sender {
    [self clearNumber];
}

- (IBAction)operationButtonPressed:(UIButton *)sender {
    self.textLabel.text = [self.calculator didPressOperation:sender.titleLabel.text];
}

- (IBAction)onCalculateButtonPressed:(UIButton *)sender {
    self.textLabel.text = [self.calculator didPressEquals];
    
}

@end

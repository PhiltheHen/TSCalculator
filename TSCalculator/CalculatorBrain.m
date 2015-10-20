//
//  CalculatorBrain.m
//  TSwiftCalculator
//
//  Created by Philip Henson on 10/5/15.
//  Copyright © 2015 Phil Henson. All rights reserved.
//

#import "CalculatorBrain.h"

@implementation CalculatorBrain

-(instancetype)init{
    if (self = [super init]){
        self.isStillEditing = NO;
        self.equation = [[NSMutableArray alloc] init];
        self.result = @"0";
    }

    return self;
}

- (void)clearAll {
    [self.equation removeAllObjects];
    self.isStillEditing = NO;
}

- (NSString *)didPressNumber:(NSString *)number {
    // Want to append numbers if user is entering more than a one-digit number
    if ([self.result isEqualToString:@"0"] && [number isEqualToString:@"0"]){
        //return nil;

    } else if ([self.result containsString:@"."] && [number isEqualToString:@"."] && self.isStillEditing){
       // return nil;

    }else if (self.isStillEditing){
        NSString* newValue= [NSString stringWithFormat:@"%@%@", self.result, number];

        self.result = newValue;

    } else if (self.equation.count == 1){

        // If the user has hit equals recently, there will be only one element in the array (as opposed to 2 if another operation has ben pressed) so we want to handle that case separately
        [self.equation removeAllObjects];

        self.result = number;
    }else {
        // default behavior for entering a number for the first time, or after a clear/shake
        self.result = number;
    }

    self.isStillEditing = YES;

    return self.result;
    

}

- (NSString *)didPressOperation:(NSString *)operation {

    if (self.equation.count < 2){
        // If no operations are in the array yet
        [self.equation addObject:self.result];
        [self.equation addObject:operation];
    } else if ([operation isEqualToString:@"+"] ||
               [operation isEqualToString:@"-"] ||
               [operation isEqualToString:@"*"] ||
               [operation isEqualToString:@"/"])
    {
        // handle if multiple operations are added in a row
        [self.equation removeLastObject];
        [self.equation addObject:operation];
    }
    else
    {

        // Otherwise call the function to do the math here
        double currentAnswer = [self performOperationOnNumber:[self.equation objectAtIndex:0] withOperator:[self.equation lastObject] onSecondNum:self.result];

        [self.equation removeAllObjects];
        self.result = [NSString stringWithFormat:@"%.2f", currentAnswer];
        [self.equation addObject:self.result];
        [self.equation addObject:operation];
    }

    self.isStillEditing = NO;

    return self.result;


}

-(double)performOperationOnNumber:(NSString *)firstNum withOperator:(NSString *)operation onSecondNum:(NSString *)secondNum
{
    double currentAnswer = [firstNum doubleValue];

    if ([operation isEqualToString:@"+"]){
        currentAnswer = currentAnswer + [secondNum doubleValue];
    } else if ([operation isEqualToString:@"-"]){
        currentAnswer = currentAnswer - [secondNum doubleValue];

    } else if ([operation isEqualToString:@"*"]){
        currentAnswer = currentAnswer * [secondNum doubleValue];

    } else if ([operation isEqualToString:@"/"]){
        currentAnswer = currentAnswer / [secondNum doubleValue];

    }

    return currentAnswer;
}

- (NSString *)didPressEquals {
    // Need to handle a bit differently than other operators, but still use the math function
    double answer;

    if (self.equation.count > 0){

        answer = [self performOperationOnNumber:[self.equation objectAtIndex:0] withOperator:[self.equation lastObject] onSecondNum:self.result];

        [self.equation removeAllObjects];
        [self.equation addObject:[NSString stringWithFormat:@"%.2f", answer]];

    } else {
        // Handle the case where the user just hits enter after entering a number - should do nothing
        answer = [self.result doubleValue];
    }

    self.result = [NSString stringWithFormat:@"%g", answer];
    
    self.isStillEditing = NO;

    return self.result;
}



@end

//
//  CalculatorBrain.h
//  TSwiftCalculator
//
//  Created by Philip Henson on 10/5/15.
//  Copyright © 2015 Phil Henson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CalculatorBrain : NSObject

@property (nonatomic) NSString *operation;
@property (nonatomic) NSString *number;
@property (nonatomic) NSMutableArray *equation;
@property (nonatomic) NSString *result;
@property BOOL isStillEditing;

- (void)clearAll;

- (NSString *)didPressNumber:(NSString *)number;

- (NSString *)didPressOperation:(NSString *)operation;

- (NSString *)didPressEquals;

@end

//
//  Random.m
//  Geo Master
//
//  Created by Chao, Yongqi on 4/8/14.
//  Copyright (c) 2014 ios.uiowa. All rights reserved.
//

#import "Random.h"

@implementation Random

+ (NSInteger)randomIntegerFrom:(NSInteger)fromInteger to:(NSInteger)toInteger {
    if (fromInteger > toInteger) {
        NSInteger tempInteger = fromInteger;
        fromInteger = toInteger;
        toInteger = tempInteger;
    }
    
    NSInteger difference = toInteger - fromInteger;
    return fromInteger + arc4random() % (difference + 1);
}

+ (CGFloat)randomFloatFrom:(CGFloat)fromFloat to:(CGFloat)toFloat {
    if (fromFloat > toFloat) {
        CGFloat tempFloat = fromFloat;
        fromFloat = toFloat;
        toFloat = tempFloat;
    }
    
    CGFloat difference = toFloat - fromFloat;
    return ((double)arc4random() / 0x100000000) * difference + fromFloat;
}

@end
//
//  GeoGame.m
//  Geo Master
//
//  Created by Volker, Joseph on 4/6/14.
//  Copyright (c) 2014 ios.uiowa. All rights reserved.
//

#import "GeoGame.h"
#import <GoogleMaps/GoogleMaps.h>

@implementation GeoGame


//return the distance from a given set of coordinates to the target set of coordinates
-(void)calculateScore:(NSArray*)guessedCoords
               second:(NSArray*)coordinatesToGuess
{
    double lat1 = [[coordinatesToGuess objectAtIndex:0] doubleValue];
    double long1 = [[coordinatesToGuess objectAtIndex:1] doubleValue];
    double lat2 = [[guessedCoords objectAtIndex:0] doubleValue];
    double long2 = [[guessedCoords objectAtIndex:1] doubleValue];
    
    double a2 = pow((long1 - long2), 2);
    double b2 = pow((lat2 - lat1), 2);
    int x =(int)100 - sqrt(a2 + b2);
    if (x<90 &&  x>80) {
        x = x -10;
    }
    if (x<80 && x>70) {
        x = x -15;
    }
    if (x<70 && x>60) {
        x = x -25;
    }
    if (x<60 && x>50) {
        x = x -40;
    }
    
    _score = [ NSNumber numberWithInt:(int)x*10];
    
    NSLog(@"Socre %@",_score);
}

@end
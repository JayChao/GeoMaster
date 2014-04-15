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

-(NSArray*)coordinatesToGuess:(NSArray*)CoordsToGuess
{
    _coordinatesToGuess = CoordsToGuess;
    return _coordinatesToGuess;
}

//return the distance from a given set of coordinates to the target set of coordinates
-(void)calculateScore:(NSArray*)guessedCoords
{
    double lat1 = [[_coordinatesToGuess objectAtIndex:0] doubleValue];
    double long1 = [[_coordinatesToGuess objectAtIndex:1] doubleValue];
    double lat2 = [[guessedCoords objectAtIndex:0] doubleValue];
    double long2 = [[guessedCoords objectAtIndex:1] doubleValue];
    
    
    NSLog(@"g %f",lat1);
    NSLog(@"guessedCoords %f",lat2);
    
    double a2 = pow((long1 - long2), 2);
    double b2 = pow((lat2 - lat1), 2);
    _score = [NSNumber numberWithDouble:sqrt(a2 + b2)];
}

@end
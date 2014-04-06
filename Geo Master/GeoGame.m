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

-(NSArray*)coordinatesToGuess
{
    if(!_coordinatesToGuess)
        _coordinatesToGuess = [[NSArray alloc] init];
    
    _coordinatesToGuess = [NSArray arrayWithObjects:[NSNumber numberWithDouble:6.8], [NSNumber numberWithDouble: 39.2833], nil];
    return _coordinatesToGuess;
}

//return the distance from a given set of coordinates to the target set of coordinates
-(void)calculateScore:(NSArray*)guessedCoords
{
    double lat1 = [[_coordinatesToGuess objectAtIndex:0] doubleValue];
    double long1 = [[_coordinatesToGuess objectAtIndex:1] doubleValue];
    double lat2 = [[guessedCoords objectAtIndex:0] doubleValue];
    double long2 = [[guessedCoords objectAtIndex:1] doubleValue];
    
    double a2 = pow((long1 - long2), 2);
    double b2 = pow((lat2 - lat1), 2);
    _score = [NSNumber numberWithDouble:sqrt(a2 + b2)];
}

@end
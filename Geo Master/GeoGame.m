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

//uses the haversine formula to calculate the distance
//between two sets of geocoordinates
//when I ran it, i had rounding error of 2%, so it should be acceptable
-(void)calculateScore:(NSArray*)guessedCoords
{
    double lat1rad = [[_coordinatesToGuess objectAtIndex:0] doubleValue] * M_PI/180;
    double long1rad = [[_coordinatesToGuess objectAtIndex:1] doubleValue] * M_PI/180;
    double lat2rad = [[guessedCoords objectAtIndex:0] doubleValue] * M_PI/180;
    double long2rad = [[guessedCoords objectAtIndex:1] doubleValue] * M_PI/180;
    
    double dLat = lat2rad - lat1rad;
    double dLong = long2rad - long1rad;
    
    double a = (2 * sin(dLat*1000 / 2)) + ((2 * sin(dLong*1000/2)) * cos(lat1rad*1000) * cos(lat2rad*1000));
    double c = 2 * asin(sqrt(a));
    
    _score = [NSNumber numberWithDouble:6372.8 * c];
    NSLog(@"lat1rad %f", lat1rad);
    NSLog(@"long1rad %f", long1rad);
    NSLog(@"lat2rad %f", lat2rad);
    NSLog(@"long2rad %f", long2rad);
}

@end
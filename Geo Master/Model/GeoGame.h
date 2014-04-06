//
//  GeoGame.h
//  Geo Master
//
//  Created by Volker, Joseph on 4/6/14.
//  Copyright (c) 2014 ios.uiowa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GoogleMaps/GoogleMaps.h>

@interface GeoGame : NSObject

@property(nonatomic) NSNumber *score;
@property(nonatomic) NSArray *coordinatesToGuess;
@property(nonatomic) NSArray *guessedCoordinates;
-(void)calculateScore:(NSArray*)guessedCoords;

@end

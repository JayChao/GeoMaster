//
//  GeoViewController.m
//  Geo Master
//
//  Created by Chao, Yongqi on 4/6/14.
//  Copyright (c) 2014 ios.uiowa. All rights reserved.
//

#import "GeoViewController.h"
#import "GeoGame.h"

#import <GoogleMaps/GoogleMaps.h>

@implementation GeoViewController {
    GMSMapView *mapView_;
}

- (void)viewDidLoad {
    // Create a GMSCameraPosition that tells the map to display the
    // coordinate -33.86,151.20 at zoom level 6.
    GeoGame *game = [[GeoGame alloc] init];
    NSNumber *lat = [[game coordinatesToGuess] objectAtIndex:0];
    NSNumber *lon = [[game coordinatesToGuess] objectAtIndex:1];
        GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:[lat doubleValue]
                                                                longitude:[lon doubleValue]
                                                                     zoom:6];
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.myLocationEnabled = YES;
    self.view = mapView_;
    
    // Creates a marker in the center of the map.
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(-33.86, 151.20);
    marker.title = @"Beijing";
    marker.snippet = @"China";
    marker.map = mapView_;
    NSArray *arr = [NSArray arrayWithObjects:[NSNumber numberWithDouble:-33.86], [NSNumber numberWithDouble: 151.20], nil];
    [game calculateScore:arr];
           
    NSLog(@"%@", [game score]);
}

@end


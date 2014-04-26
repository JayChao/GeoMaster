
//
//  MapViewController.h
//  Geo Master
//
//  Created by Chao, Yongqi on 4/8/14.
//  Copyright (c) 2014 ios.uiowa. All rights reserved.
//


#import "MapViewController.h"
#import "GeoGame.h"
#import "StreetViewController.h"

#import <GoogleMaps/GoogleMaps.h>

@interface MapViewController () <GMSMapViewDelegate>

@property (strong,nonatomic)StreetViewController *StreetViewController;

@end

@implementation MapViewController {
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];

    
    
    // Create a button that, when pressed, updates the camera to fit the bounds
    // of the specified markers.

}




@end

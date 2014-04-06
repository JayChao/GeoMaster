//
//  GeoViewController.m
//  Geo Master
//
//  Created by Chao, Yongqi on 4/6/14.
//  Copyright (c) 2014 ios.uiowa. All rights reserved.
//

#import "GeoViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import "PanoramaViewController.h"

@interface GeoViewController ()
@end

@implementation GeoViewController {
    GMSMapView *mapView_;
}


- (void)viewDidLoad {
    // Create a GMSCameraPosition that tells the map to display the
    // coordinate -33.86,151.20 at zoom level 6.
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-33.86
                                                            longitude:151.20
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
    
    
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(40, 40, 70, 70)];
    
    backButton.titleLabel.text=@"StreetView";
    
    backButton.titleLabel.textColor=[UIColor redColor];
    
    [mapView_ addSubview:backButton];

}

@end


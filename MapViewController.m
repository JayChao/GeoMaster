
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

@property (nonatomic) BOOL thereIsAPin;
@property (strong,nonatomic)StreetViewController *StreetViewController;
@property (nonatomic) GeoGame *game;

@end

@implementation MapViewController {
    GMSMapView *mapView_;
    NSMutableArray *markers_;
    CLLocationCoordinate2D coordinate;
    
}
//-(instancetype)init

-(instancetype)loadWithCoordintae:(CLLocationCoordinate2D) cd{
    
    coordinate=cd;
    
    return self;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:41
                                                            longitude:-87
                                                                 zoom:2];
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.delegate = self;
    self.view = mapView_;
    [mapView_ clear];
    self.game = [[GeoGame alloc]init];
    
    // Create a button that, when pressed, updates the camera to fit the bounds
    // of the specified markers.
    UIButton *Switch=[[UIButton alloc]initWithFrame:CGRectMake(10, 30, 70, 40)];
    [Switch setTitle:@"Back" forState:UIControlStateNormal];
    [Switch setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.view addSubview:Switch];
    [Switch addTarget:self action:@selector(switchView) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didTapFitBounds {
    GMSCoordinateBounds *bounds;
    for (GMSMarker *marker in markers_) {
        if (bounds == nil) {
            bounds = [[GMSCoordinateBounds alloc] initWithCoordinate:marker.position
                                                          coordinate:marker.position];
        }
        bounds = [bounds includingCoordinate:marker.position];
    }
    GMSCameraUpdate *update = [GMSCameraUpdate fitBounds:bounds
                                             withPadding:50.0f];
    [mapView_ moveCamera:update];
    
    
}

#pragma mark - GMSMapViewDelegat

- (void)mapView:(GMSMapView *)mapView
didLongPressAtCoordinate:(CLLocationCoordinate2D)coordinate {
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.title = [NSString stringWithFormat:@"Marker at: %.2f,%.2f",
                    coordinate.latitude, coordinate.longitude];
    
    //GeoGame.coordinateGiven = [
    NSArray *gameArray = [NSArray arrayWithObjects:[NSNumber numberWithDouble:coordinate.latitude], [NSNumber numberWithDouble:coordinate.longitude],nil];
    
    [self.game calculateScore:gameArray];
    
    marker.map = nil;
    marker.position = coordinate;
    marker.appearAnimation = kGMSMarkerAnimationPop;
    marker.map = mapView_;
    
    // delete the new marker to the list of markers.
    
}

-(void)switchView{
    //StreetViewController *StreeVC=[[StreetViewController alloc]init];
    [self dismissViewControllerAnimated:YES completion:^{}];
    
}


@end

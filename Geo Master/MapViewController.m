#if !defined(__has_feature) || !__has_feature(objc_arc)
#error "This file requires ARC support."
#endif

#import "MapViewController.h"
#import "GeoGame.h"
#import "StreetViewController.h"

#import <GoogleMaps/GoogleMaps.h>

@interface MapViewController () <GMSMapViewDelegate>
@property (nonatomic) BOOL thereIsAPin;
@property (nonatomic) GeoGame *game;
@end

@implementation MapViewController {
  GMSMapView *mapView_;
  NSMutableArray *markers_;
}
//-(instancetype)init

- (void)viewDidLoad {
  [super viewDidLoad];
  GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:6.8
                                                          longitude:0.966085
                                                               zoom:4];
  mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
  mapView_.delegate = self;
  self.view = mapView_;
    [mapView_ clear];
    self.game = [[GeoGame alloc]init];
	NSLog(@"%@", [[self.game coordinatesToGuess] objectAtIndex:0]);
    NSLog(@"%@", [[self.game coordinatesToGuess] objectAtIndex:1]);

  // Create a button that, when pressed, updates the camera to fit the bounds
  // of the specified markers.
  UIBarButtonItem *fitBoundsButton =
      [[UIBarButtonItem alloc] initWithTitle:@"Fit Bounds"
                                       style:UIBarButtonItemStylePlain
                                      target:self
                                      action:@selector(didTapFitBounds)];
  self.navigationItem.rightBarButtonItem = fitBoundsButton;
    
    UIButton *streetView = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    streetView.frame = CGRectMake(mapView_.bounds.size.width - 110, mapView_.bounds.size.height - 30, 100, 20);
    streetView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin;
    [streetView setTitle:@"Street View" forState:UIControlStateNormal];
    StreetViewController *View2Controller = [[StreetViewController alloc] initWithNibName:@"View2" bundle:nil];
    [self.navigationController pushViewController:View2Controller animated:YES];
    [mapView_ addSubview:streetView];
    

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
    NSLog(@"titile %@",marker.title);
    
 //GeoGame.coordinateGiven = [
    NSArray *gameArray = [NSArray arrayWithObjects:[NSNumber numberWithDouble:coordinate.latitude], [NSNumber numberWithDouble:coordinate.longitude],nil];
    
    [self.game calculateScore:gameArray];
    NSLog(@"print %@", [self.game score]);
    
    marker.map = nil;
  marker.position = coordinate;
  marker.appearAnimation = kGMSMarkerAnimationPop;
  marker.map = mapView_;

  // delete the new marker to the list of markers.

}


@end

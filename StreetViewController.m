//this class can generate a random coordinate of a Street view in Chicago







//  StreetViewController.m
//  Geo Master
//
//  Created by Shufang Han on 14-4-6.
//  Copyright (c) 2014年 ios.uiowa. All rights reserved.
//

#import "StreetViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import "XMLParser.h"
#import "Random.h"

#import "GeoGame.h"

@interface StreetViewController ()<GMSPanoramaViewDelegate,GMSMapViewDelegate>
@property (strong,nonatomic)NSMutableString *randomCityName;
@property XMLParser *parser;
@property UILabel *scoreLable;
@property (nonatomic) GeoGame *game;

@end

@implementation StreetViewController
GMSPanoramaView *view_;
GMSMapView *mapView_;
CLLocationCoordinate2D coordinatesToGuess;



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.game = [[GeoGame alloc]init];
    self.scoreLable=[[UILabel alloc]initWithFrame:CGRectMake(90, 90, 180, 40)];
    
    [self showStreetView];
}

-(void)findRandomPlace{
    
}

-(void)setCoordinate{
    self.parser=[[XMLParser alloc] loadXMLByURL:@"http://maps.google.com/maps/api/geocode/xml?address=chicago&sensor=true"];
    
    double southwest_lat=[self.parser.southwest_lat doubleValue];
    double southwest_lng=[self.parser.southwest_lng doubleValue];
    double northeast_lat=[self.parser.northeast_lat doubleValue];
    double northeast_lng=[self.parser.northeast_lng doubleValue];
    double lat   =   [Random randomFloatFrom:southwest_lat to:northeast_lat];
    double lng   =   [Random randomFloatFrom:southwest_lng to:northeast_lng];
    
    coordinatesToGuess.latitude     =   lat;
    coordinatesToGuess.longitude    =   lng;
    NSLog(@"START LOCATION %.20g,%.20g",lat,lng);
}


-(CLLocationCoordinate2D)getCoordinate{
    return coordinatesToGuess;
}



-(void)showStreetView{
    [self findRandomPlace];
    [self setCoordinate];
    view_ = [GMSPanoramaView panoramaWithFrame:CGRectZero nearCoordinate:coordinatesToGuess radius:2000];
    view_.camera = [GMSPanoramaCamera cameraWithHeading:180 pitch:-10 zoom:0];
    view_.delegate = self;
    view_.orientationGestures = YES;
    view_.navigationGestures = YES;
    view_.navigationLinksHidden = YES;
    view_.streetNamesHidden=YES;
    self.view = view_;
    
    UIButton *Switch=[[UIButton alloc]initWithFrame:CGRectMake(10, 30, 70, 40)];
    [Switch setTitle:@"Map" forState:UIControlStateNormal];
    [Switch setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:Switch];
    [Switch addTarget:self action:@selector(switchView) forControlEvents:UIControlEventTouchUpInside];
    
}





//Following code is MapView

-(void)switchView{
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:41
                                                            longitude:-87
                                                                 zoom:2];
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.delegate = self;
    self.view = mapView_;
    
    
    
    UIButton *Switch=[[UIButton alloc]initWithFrame:CGRectMake(10, 30, 70, 40)];
    [Switch setTitle:@"Back" forState:UIControlStateNormal];
    [Switch setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.view addSubview:Switch];
    [Switch addTarget:self action:@selector(backView) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    
}

- (void)mapView:(GMSMapView *)mapView
didLongPressAtCoordinate:(CLLocationCoordinate2D)coordinate {
    GMSMarker *marker = [[GMSMarker alloc] init];
    [mapView_ clear];
    self.scoreLable.text = nil;
    
    marker.title = [NSString stringWithFormat:@"Marker at: %.2f,%.2f",
                    coordinate.latitude, coordinate.longitude];
    
    NSArray *gameArray = [NSArray arrayWithObjects:[NSNumber numberWithDouble:coordinate.latitude], [NSNumber numberWithDouble:coordinate.longitude],nil];
    NSArray *coordinatesToGuess = [NSArray arrayWithObjects:[NSNumber numberWithDouble:self.getCoordinate.latitude],[NSNumber numberWithDouble:self.getCoordinate.longitude],nil];;
    
    marker.position = coordinate;
    marker.appearAnimation = kGMSMarkerAnimationPop;
    marker.map = mapView_;
    
    [self.game calculateScore:gameArray
                       second:coordinatesToGuess];
    
    //UILabel *scoreLable=[[UILabel alloc]initWithFrame:CGRectMake(90, 90, 180, 40)];
    NSString *text = [NSString stringWithFormat:@"Score is %@",self.game.score];
    [self.scoreLable setText:text];
    self.scoreLable.textColor = [UIColor blackColor];
    self.scoreLable.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:self.scoreLable];
    // delete the new marker to the list of markers.
}

-(void)backView{
    //StreetViewController *StreeVC=[[StreetViewController alloc]init];
    //[self dismissViewControllerAnimated:YES completion:^{}];
    self.view = view_;
    
}


@end
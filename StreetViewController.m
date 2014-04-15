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
#import "MapViewController.h"
#import "GeoGame.h"

@interface StreetViewController ()<GMSPanoramaViewDelegate>
@property (strong,nonatomic)NSMutableString *randomCityName;
@property XMLParser *parser;

@property (strong,nonatomic)MapViewController *MapViewController;
@property (nonatomic) GeoGame *game;

@end

@implementation StreetViewController
GMSPanoramaView *view_;
CLLocationCoordinate2D coordinate;



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    
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
    
    coordinate.latitude     =   lat;
    coordinate.longitude    =   lng;
    NSLog(@"START LOCATION %.20g,%.20g",lat,lng);
    [self.game setCoordinatesToGuess:[NSArray arrayWithObjects:[NSNumber numberWithDouble: lat],[NSNumber numberWithDouble: lng],nil]];
}


-(CLLocationCoordinate2D)getCoordinate{
    return coordinate;
}



-(void)showStreetView{
    [self findRandomPlace];
    [self setCoordinate];
    view_ = [GMSPanoramaView panoramaWithFrame:CGRectZero nearCoordinate:coordinate radius:2000];
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

-(void)switchView{
    MapViewController *StreeVC=[[MapViewController alloc]loadWithCoordintae:coordinate];
    [self presentViewController:StreeVC animated:NO completion:^{}];
    
}


@end
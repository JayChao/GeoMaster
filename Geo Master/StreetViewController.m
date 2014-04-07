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

@interface StreetViewController ()<GMSPanoramaViewDelegate>
@property (strong,nonatomic)NSMutableString *randomCityName;

@property XMLParser *parser;
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
    
    NSLog(@"%@ %@ %@ %@",self.parser.southwest_lat,self.parser.southwest_lng,self.parser.northeast_lat,self.parser.northeast_lng);
    double southwest_lat=[self.parser.southwest_lat doubleValue];
    double southwest_lng=[self.parser.southwest_lng doubleValue];
    double northeast_lat=[self.parser.northeast_lat doubleValue];
    double northeast_lng=[self.parser.northeast_lng doubleValue];
    double lat   =   [Random randomFloatFrom:southwest_lat to:northeast_lat];
    double lng   =   [Random randomFloatFrom:southwest_lng to:northeast_lng];

    coordinate.latitude     =   lat;
    coordinate.longitude    =   lng;
    NSLog(@"%.20g,%.20g",lat,lng);
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
}


@end

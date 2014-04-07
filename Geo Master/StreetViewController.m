//
//  StreetViewController.m
//  Geo Master
//
//  Created by Shufang Han on 14-4-6.
//  Copyright (c) 2014年 ios.uiowa. All rights reserved.
//

#import "StreetViewController.h"
#import "RandomPlace.h"
#import <GoogleMaps/GoogleMaps.h>


@interface StreetViewController ()<GMSPanoramaViewDelegate>
//a list of all cities that Google Map Street View covered
@property (strong,nonatomic)NSMutableArray* citiesList;

@property RandomPlace *randomPlace;

@end


@implementation StreetViewController

GMSPanoramaView *view_;
//Coordinate of random place


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.randomPlace=[[RandomPlace alloc]init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
        
    [self showStreetView];
}

-(CLLocationCoordinate2D)getCoordinate{
    return [self.randomPlace getCoordinate];
}


-(void)showStreetView{
    view_ = [GMSPanoramaView panoramaWithFrame:CGRectZero nearCoordinate:[self.randomPlace getCoordinate]];
    view_.camera = [GMSPanoramaCamera cameraWithHeading:180 pitch:-10 zoom:0];
    view_.delegate = self;
    view_.orientationGestures = YES;
    view_.navigationGestures = YES;
    view_.navigationLinksHidden = YES;
    view_.streetNamesHidden=YES;
    self.view = view_;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

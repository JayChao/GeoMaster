//
//  OpenViewController.m
//  Geo Master
//
//  Created by Shufang Han on 14-4-15.
//  Copyright (c) 2014年 ios.uiowa. All rights reserved.
//

#import "OpenViewController.h"
#import "MainViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import "UIButton+Bootstrap.h"


@interface OpenViewController ()
@property (strong, nonatomic) IBOutlet UILabel *TitleLabel;
@property (strong, nonatomic) IBOutlet UIButton *startButton;
@end


@implementation OpenViewController {
    GMSMapView *mapView_;
    NSTimer *timer;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:40.748480
                                                            longitude:-73.985843
                                                                 zoom:20
                                                              bearing:0
                                                         viewingAngle:0];
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.settings.zoomGestures = NO;
    mapView_.settings.scrollGestures = NO;
    mapView_.settings.rotateGestures = NO;
    mapView_.settings.tiltGestures = NO;
    self.view = mapView_;
    [self.startButton primaryStyle];
    [self.view addSubview:self.startButton];
    

    [self.view addSubview:self.TitleLabel];
}


- (void)moveCamera {
    GMSCameraPosition *camera = mapView_.camera;
    float zoom = fmaxf(camera.zoom - 0.1f, 0.5f);
    
    GMSCameraPosition *newCamera =
    [[GMSCameraPosition alloc] initWithTarget:camera.target
                                         zoom:zoom
                                      bearing:camera.bearing + 10
                                 viewingAngle:camera.viewingAngle + 10];
    [mapView_ animateToCameraPosition:newCamera];
    NSLog(@"%f",camera.zoom);
    if(camera.zoom<10.5f){
        mapView_.mapType=kGMSTypeSatellite;
    }
    

    if(camera.zoom<=2.3f){
        [timer invalidate];
        mapView_.settings.zoomGestures = YES;
        mapView_.settings.scrollGestures = YES;
        mapView_.settings.rotateGestures = YES;
        
    }
}

- (void)viewDidAppear:(BOOL)animated {
    timer = [NSTimer scheduledTimerWithTimeInterval:1.f/30.f
                                             target:self
                                           selector:@selector(moveCamera)
                                           userInfo:nil
                                            repeats:YES];
}

- (void)viewDidDisappear:(BOOL)animated {
    [timer invalidate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [timer invalidate];
}

@end

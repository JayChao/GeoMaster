//
//  GeoTutorialChildViewController.m
//  Geo Master
//
//  Created by Volker, Joseph on 4/29/14.
//  Copyright (c) 2014 ios.uiowa. All rights reserved.
//

#import "GeoTutorialChildViewController.h"

@interface GeoTutorialChildViewController ()


@end

@implementation GeoTutorialChildViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        // Custom initialization
    }
    
    return self;
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
//    [self.textView setText:[NSString stringWithFormat:@"%d", self.index]];
    switch (self.index)
    {
        case 0:
            [self.maptypeView setText:[NSString stringWithFormat:@"Street View"]];
            [self.textView setText:[NSString stringWithFormat:@"Swipe in any direction to move the camera around"]];
            break;
            
        case 1:
            [self.maptypeView setText:[NSString stringWithFormat:@"Street View"]];
            [self.textView setText:[NSString stringWithFormat:@"Tap twice to move in the direction you are pointing towards"]];
            break;
            
        case 2:
            [self.maptypeView setText:[NSString stringWithFormat:@"Map View"]];
            [self.textView setText:[NSString stringWithFormat:@"Zoom in/out of the map by pinching in/out"]];
            break;
            
        case 3:
            [self.maptypeView setText:[NSString stringWithFormat:@"Map View"]];
            [self.textView setText:[NSString stringWithFormat:@"Hold your finger down to place a pin where you think the location is"]];
            break;
            
        default:
            [self.maptypeView setText:[NSString stringWithFormat:@""]];
            [self.textView setText:[NSString stringWithFormat:@""]];
            break;
    }
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
//
//  MapViewController.h
//  Geo Master
//
//  Created by Chao, Yongqi on 4/8/14.
//  Copyright (c) 2014 ios.uiowa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GeoGame.h"

@interface MapViewController : UIViewController
-(id)loadWithCoordintae:(CLLocationCoordinate2D) cd;
@end

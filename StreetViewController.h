//
//  StreetViewController.h
//  Geo Master
//
//  Created by Shufang Han on 14-4-6.
//  Copyright (c) 2014年 ios.uiowa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import <FacebookSDK/FacebookSDK.h>

@interface StreetViewController : UIViewController <FBUserSettingsDelegate>
-(CLLocationCoordinate2D)getCoordinate;

@end

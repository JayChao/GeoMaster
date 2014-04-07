//
//  RandomPlace.m
//  Geo Master
//
//  Created by Shufang Han on 14-4-6.
//  Copyright (c) 2014年 ios.uiowa. All rights reserved.
//

#import "RandomPlace.h"
#import <GoogleMaps/GoogleMaps.h>

@interface RandomPlace ()
@property CLLocationCoordinate2D coordinate;
@end

@implementation RandomPlace

-(instancetype)init{
    self=[super init];
    if (self) {
        [self test];
        self.coordinate=CLLocationCoordinate2DMake(130, 45);
    }
    return self;
}

-(void)test{
    NSString *address=@"iowa city,iowa";
    CLGeocoder *geocoder=[[CLGeocoder alloc]init];
    [geocoder geocodeAddressString:address completionHandler:^(NSArray *placemarks, NSError *error) {
        if ([placemarks count]) {
            CLPlacemark *placemark = [placemarks objectAtIndex:0];
            CLLocation *location = placemark.location;
            CLLocationCoordinate2D coordinate2= location.coordinate;
            _coordinate=coordinate2;
        }
        
    }];
    
}

-(CLLocationCoordinate2D)getCoordinate{
    return self.coordinate;
}

@end

//
//  GeoHighScoresViewController.h
//  Geo Master
//
//  Created by Volker, Joseph on 4/30/14.
//  Copyright (c) 2014 ios.uiowa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GeoRecord.h"
#import "GeoRecordCollection.h"

@interface GeoHighScoresViewController : UITableViewController <UITableViewDataSource>
@property(retain, nonatomic) GeoRecordCollection* recordCollection;

@end

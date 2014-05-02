//
//  GeoRecord.h
//  Geo Master
//
//  Created by Volker, Joseph on 4/30/14.
//  Copyright (c) 2014 ios.uiowa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GeoRecord : NSObject

@property NSString* playerName;
@property NSNumber* score;
@property (setter = setSortDescriptor:)NSSortDescriptor* sortdescriptor;

-(NSComparisonResult)compare:(GeoRecord*)otherRecord;
@end

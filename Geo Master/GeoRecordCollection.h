//
//  GeoRecordCollection.h
//  Geo Master
//
//  Created by Volker, Joseph on 4/30/14.
//  Copyright (c) 2014 ios.uiowa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GeoRecord.h"

@interface GeoRecordCollection : NSObject

-(void)addRecord:(GeoRecord*)newRecord;
-(NSArray*)getOrderedrecordList;
-(NSUInteger)getCount;

@end

//
//  GeoRecordCollection.m
//  Geo Master
//
//  Created by Volker, Joseph on 4/30/14.
//  Copyright (c) 2014 ios.uiowa. All rights reserved.
//

#import "GeoRecordCollection.h"

@interface GeoRecordCollection()
@property (strong, nonatomic)NSMutableArray *recordCollection;
@end

@implementation GeoRecordCollection

-(NSMutableArray*)recordCollection
{
    if(_recordCollection == nil)
        _recordCollection = [[NSMutableArray alloc] init];
    return _recordCollection;
}

-(void)addRecord:(GeoRecord *)newRecord
{
    if(self.recordCollection)
    {
        [self.recordCollection addObject:newRecord];
    }
}

//returns an array where the 0th record is the highest score, 1th record is next highest, ...
-(NSArray*)getOrderedrecordList
{
    return [self.recordCollection sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2)
    {
        return [[obj2 score] compare:[obj1 score]];
    }];
}

-(NSUInteger)getCount
{
    return [self.recordCollection count];
}

@end

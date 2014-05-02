//
//  GeoRecord.m
//  Geo Master
//
//  Created by Volker, Joseph on 4/30/14.
//  Copyright (c) 2014 ios.uiowa. All rights reserved.
//

#import "GeoRecord.h"

@implementation GeoRecord

-(NSComparisonResult)compare:(GeoRecord*)otherRecord
{
    return [self.score compare:otherRecord.score];
}

-(NSSortDescriptor*)setSortDescriptor
{
    if(!_sortdescriptor)
    {
        _sortdescriptor = [[NSSortDescriptor alloc]
                               initWithKey:@"score"
                               ascending:YES];
    }
    return _sortdescriptor;
}

@end

//
//  GeoRecordTestCase.m
//  Geo Master
//
//  Created by Volker, Joseph on 4/30/14.
//  Copyright (c) 2014 ios.uiowa. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "GeoRecord.h"
#import "GeoRecordCollection.h"

@interface GeoRecordTestCase : XCTestCase

@end

@implementation GeoRecordTestCase

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

-(void)testGeoRecordAddRecord
{
    GeoRecord *record1 = [[GeoRecord alloc] init];
    record1.score = [NSNumber numberWithDouble:13.0];
    GeoRecord *record2 = [[GeoRecord alloc] init];
    record2.score = [NSNumber numberWithDouble:187.0];
    GeoRecord *record3 = [[GeoRecord alloc] init];
    record3.score = [NSNumber numberWithDouble:99.34];
    
    GeoRecordCollection *records = [[GeoRecordCollection alloc] init];
    [records addRecord:record1];
    [records addRecord:record2];
    [records addRecord:record3];
    
    XCTAssertEqual((unsigned int)3, [records getCount]);
}

-(void)testGeoRecordSortRecords
{
    GeoRecord *record1 = [[GeoRecord alloc] init];
    record1.score = [NSNumber numberWithDouble:13.0];
    GeoRecord *record2 = [[GeoRecord alloc] init];
    record2.score = [NSNumber numberWithDouble:187.0];
    GeoRecord *record3 = [[GeoRecord alloc] init];
    record3.score = [NSNumber numberWithDouble:99.34];
    
    GeoRecordCollection *records = [[GeoRecordCollection alloc] init];
    [records addRecord:record1];
    [records addRecord:record2];
    [records addRecord:record3];
    
    NSArray* sortedRecords = [records getOrderedrecordList];

    XCTAssertEqual(187.0, [[[sortedRecords objectAtIndex:0] score] doubleValue]);
    XCTAssertEqual(99.34, [[[sortedRecords objectAtIndex:1] score] doubleValue]);
    XCTAssertEqual(13.0, [[[sortedRecords objectAtIndex:2] score] doubleValue]);
}

@end

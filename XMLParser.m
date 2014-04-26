//
//  XMLParser.m
//  Geo Master
//
//  Created by Shufang Han on 14-4-6.
//  Copyright (c) 2014年 ios.uiowa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMLParser.h"
//#import "randomPalce.h"

@interface XMLParser ()
//@property randomPalce   *place;
@end
@implementation XMLParser
@synthesize address=_address;

NSMutableString     *currentNodeContent;
NSXMLParser         *parser;
bool isStatus;
bool isStatus2;

-(id)loadXMLByURL:(NSString *)urlString{
    urlString=[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url=[NSURL URLWithString:urlString];
    NSData *data    =   [[NSData alloc]initWithContentsOfURL:url];
    parser          =   [[NSXMLParser alloc]initWithData:data];
    parser.delegate =   self;
    [parser parse];
    return self;
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    currentNodeContent = (NSMutableString *) [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    if ([elementName isEqualToString:@"viewport"]) {
        isStatus=YES;
    }
    if ([elementName isEqualToString:@"bounds"]) {
        isStatus=NO;
    }
    if ([elementName isEqualToString:@"southwest"]) {
        isStatus2=YES;
    }
    if ([elementName isEqualToString:@"northeast"]) {
        isStatus2=NO;
    }
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    if (isStatus&isStatus2) {
        if([elementName isEqualToString:@"lat"]){
            self.southwest_lat=currentNodeContent;
        }
        if ([elementName isEqualToString:@"lng"]) {
            self.southwest_lng=currentNodeContent;
        }
    }
    if (isStatus&(!isStatus2)) {
        if([elementName isEqualToString:@"lat"]){
            self.northeast_lat=currentNodeContent;
        }
        if ([elementName isEqualToString:@"lng"]) {
            self.northeast_lng=currentNodeContent;
        }
        
    }
    if ([elementName isEqualToString:@"formatted_address"]) {
        self.address=currentNodeContent;
    }
}

@end
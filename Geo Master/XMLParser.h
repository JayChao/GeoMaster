//
//  XMLParser.h
//  Geo Master
//
//  Created by Shufang Han on 14-4-6.
//  Copyright (c) 2014年 ios.uiowa. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "randomPalce.h"

@interface XMLParser : NSObject <NSXMLParserDelegate>

@property (strong,nonatomic) NSMutableString *southwest_lat;
@property (strong,nonatomic) NSMutableString *southwest_lng;
@property (strong,nonatomic) NSMutableString *northeast_lat;
@property (strong,nonatomic) NSMutableString *northeast_lng;
@property (strong,nonatomic) NSMutableString *address;

-(id)loadXMLByURL:(NSString *)urlString;

@end

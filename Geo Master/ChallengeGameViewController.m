//
//  ChallengeGameViewController.m
//  Geo Master
//
//  Created by HanShufang on 14-5-3.
//  Copyright (c) 2014年 ios.uiowa. All rights reserved.
//

#import "ChallengeGameViewController.h"
#import "StreetViewController.h"


@interface ChallengeGameViewController ()
@property NSInteger cityIndex;
@property NSString *cityName;
@end

@implementation ChallengeGameViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.cityIndex= [[NSUserDefaults standardUserDefaults]  integerForKey:@"challengeCityIndex"];
    //NSLog(@"%d",self.cityIndex);
    NSArray *cityList=[self challengeCityList];
    self.cityName=[cityList objectAtIndex:self.cityIndex];
    NSLog(@"%@",self.cityName);
}

-(NSArray*)challengeCityList{
    NSString *filePath=[[NSBundle mainBundle]pathForResource:@"challengeCityList" ofType:@"txt"];
    NSArray *array;
    if(filePath){
        NSError *error;
        NSString *cities=[NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
        array = [cities componentsSeparatedByString:@";"];
    }
    return array;
}

-(NSArray*)challengeList:(NSString*)cityName{
    NSString *filePath=[[NSBundle mainBundle]pathForResource:cityName ofType:@"txt"];
    NSArray *array;
    if(filePath){
        NSError *error;
        NSString *cities=[NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
        array = [cities componentsSeparatedByString:@";"];
    }
    return array;
}




@end

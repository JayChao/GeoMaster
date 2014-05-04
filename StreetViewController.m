
//  StreetViewController.m
//  Geo Master
//
//  Created by Shufang Han on 14-4-6.
//  Copyright (c) 2014年 ios.uiowa. All rights reserved.
//

#import "StreetViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import <Parse/Parse.h>
#import "XMLParser.h"
#import "Random.h"
#import "UIButton+Bootstrap.h"
#import "GeoGame.h"
#import "GeoRecord.h"
#import "MainViewController.h"

@interface StreetViewController ()<GMSPanoramaViewDelegate,GMSMapViewDelegate,UIGestureRecognizerDelegate>
@property (strong,nonatomic)NSMutableString *randomCityName;
@property XMLParser *parser;
@property UILabel *scoreLable;
@property (nonatomic) GeoGame *game;
@property (nonatomic) MainViewController *main;
//@property (nonatomic)UITableView *historyList;

@property UILabel *walkCountLabel;
@property UILabel *gamePrograssLable;
@property UILabel *finalResultLabel;
@property UIButton *makeGuess;
@property UIButton *Switch;

@property int walkCount;
@end

@implementation StreetViewController
GMSPanoramaView *view_;
GMSMapView *mapView_;
CLLocationCoordinate2D coordinatesToGuess;
CLLocationCoordinate2D end;
//int walkCount;


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    //self.historyList=[[UITableView alloc]initWithFrame:CGRectMake(10, 20, 300, 300) style:UITableViewStyleGrouped];
    //self.historyList.backgroundColor=[UIColor redColor];
    self.game = [[GeoGame alloc]init];
    
    self.gamePrograssLable = [[UILabel alloc] initWithFrame:CGRectMake(90, 50, 180, 40)];
    self.scoreLable=[[UILabel alloc]initWithFrame:CGRectMake(90, 90, 180, 40)];
    self.walkCountLabel=[[UILabel alloc]initWithFrame:CGRectMake(90, 90, 180, 40)];
    self.finalResultLabel=[[UILabel alloc]initWithFrame:CGRectMake(90, 230, 300, 90)];
	self.makeGuess=[[UIButton alloc]initWithFrame:CGRectMake(200, 30, 100, 20)];
    [_makeGuess setTitle:@"MakeGuess" forState:UIControlStateNormal];
    [_makeGuess setTitleColor:[UIColor redColor] forState:UIControlStateNormal];

    int gameProgress = [[NSUserDefaults standardUserDefaults]  integerForKey:@"gameProgress"];
    if (gameProgress==0) {
        UIAlertView *mBoxView =[[UIAlertView alloc]initWithTitle:@"Tip" message:@"‘Double click’ on streets to walk around \n Find more in Guides. \n \nYou will lose a small amount of points for walking" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        mBoxView.alpha=0.1;
        [mBoxView show];
    }
    
    self.walkCount=0;
    [self showStreetView];
}


-(void)oneFingerTwoTaps{
    self.walkCount++;
    NSString *text = [NSString stringWithFormat:@"You walked: %d steps",self.walkCount];
    [self.walkCountLabel setText:text];
    
}

-(void)gameWillRepeatForFiveTimes{
    int gameProgress = [[NSUserDefaults standardUserDefaults]  integerForKey:@"gameProgress"];

    gameProgress++;
    NSString *text = [NSString stringWithFormat:@"Game Progress: %d/5", gameProgress];
    [self.gamePrograssLable setText:text];
    self.gamePrograssLable.textColor = [UIColor blackColor];
    self.gamePrograssLable.backgroundColor = [UIColor clearColor];
    [[NSUserDefaults standardUserDefaults]setObject:[NSNumber numberWithInt:gameProgress] forKey:@"gameProgress"];
    [[NSUserDefaults standardUserDefaults] synchronize];

    
    
    
   if (gameProgress >= 6) {
       gameProgress = 0;
       [[NSUserDefaults standardUserDefaults]setObject:[NSNumber numberWithInt:gameProgress] forKey:@"gameProgress"];
       [[NSUserDefaults standardUserDefaults] synchronize];
       //[self.main changeToResultViewController];
       UIView *resultView=[[UIView alloc]init];
       resultView.backgroundColor=[UIColor whiteColor];
     
       
       
       NSNumber *score = [[NSUserDefaults standardUserDefaults]  objectForKey:@"finalScore"];
       NSString *text = [NSString stringWithFormat:@"Your final score is:%@ \n full score is 5000", score];
       
       [FBRequestConnection startForMeWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error)
       {
           PFObject *newrecord = [PFObject objectWithClassName:@"GeoRecord"];
           if(!error)
               newrecord[@"PlayerName"] = [result name];
           
           else
               newrecord[@"PlayerName"] = @"Guest";
           
           
           newrecord[@"Score"] = score;
           [newrecord saveInBackground];
       }];
       
       [self.finalResultLabel setText:text];
       self.finalResultLabel.textColor = [UIColor blackColor];
       self.finalResultLabel.backgroundColor = [UIColor clearColor];
       
       UIButton *playAgain=[[UIButton alloc]initWithFrame:CGRectMake(120, 300, 90, 90)];
       //[playAgain setCenter:CGPointMake(self.view.frame.size.width/2.0, self.view.frame.size.height/3.0*2)];
       [playAgain setTitle:@"play again?" forState:UIControlStateNormal];
       [playAgain setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
       //[quit primaryStyle];
       self.view=resultView;
       [self.view addSubview:playAgain];
       [playAgain addTarget:self action:@selector(playAgain) forControlEvents:UIControlEventTouchUpInside];
       
       self.view.backgroundColor=[UIColor colorWithWhite:0.800 alpha:1.000];
       
       [resultView addSubview:self.finalResultLabel];
       NSMutableArray *list=[[NSMutableArray alloc]init];
       NSArray *history= [[NSUserDefaults standardUserDefaults]  objectForKey:@"cityHistory"];
       
       UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(10, 30, 300, 20)];
       UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(10, 50, 300, 20)];

       [label1 setText:@"  Here are right answers"];
       [label2 setText:@"  Click to learn more!"];

       [self.view addSubview:label1];
       [self.view addSubview:label2];
       
       UIButton *city1=[[UIButton alloc]initWithFrame:CGRectMake(10, 80, 300, 25)];
       UIButton *city2=[[UIButton alloc]initWithFrame:CGRectMake(10, 110, 300, 25)];
       UIButton *city3=[[UIButton alloc]initWithFrame:CGRectMake(10, 140, 300, 25)];
       UIButton *city4=[[UIButton alloc]initWithFrame:CGRectMake(10, 170, 300, 25)];
       UIButton *city5=[[UIButton alloc]initWithFrame:CGRectMake(10, 200, 300, 25)];
       //city1.backgroundColor=[UIColor blueColor];
       //city2.backgroundColor=[UIColor blueColor];
       //city3.backgroundColor=[UIColor blueColor];
       //city4.backgroundColor=[UIColor blueColor];
       //city5.backgroundColor=[UIColor blueColor];

       for (NSString *city in history) {
           NSString *name=[city stringByReplacingOccurrencesOfString:@"%20" withString:@" "];
           [list addObject:name];
       }
       
       [city1 addTarget:self action:@selector(button1) forControlEvents:UIControlEventTouchUpInside];
       [city2 addTarget:self action:@selector(button2) forControlEvents:UIControlEventTouchUpInside];
       [city3 addTarget:self action:@selector(button3) forControlEvents:UIControlEventTouchUpInside];
       [city4 addTarget:self action:@selector(button4) forControlEvents:UIControlEventTouchUpInside];
       [city5 addTarget:self action:@selector(button5) forControlEvents:UIControlEventTouchUpInside];

       [city1 setTitle:[list objectAtIndex:0] forState:UIControlStateNormal];
       [city2 setTitle:[list objectAtIndex:1] forState:UIControlStateNormal];
       [city3 setTitle:[list objectAtIndex:2] forState:UIControlStateNormal];
       [city4 setTitle:[list objectAtIndex:3] forState:UIControlStateNormal];
       [city5 setTitle:[list objectAtIndex:4] forState:UIControlStateNormal];
       
       [city1 primaryStyle];
       [city2 primaryStyle];
       [city3 primaryStyle];
       [city4 primaryStyle];
       [city5 primaryStyle];

       [self.view addSubview:city1];
       [self.view addSubview:city2];
       [self.view addSubview:city3];
       [self.view addSubview:city4];
       [self.view addSubview:city5];

   }
}

-(void)playAgain{
    NSArray *history=[[NSArray alloc]init];
    [[NSUserDefaults standardUserDefaults]setObject:[NSNumber numberWithInt:0] forKey:@"gameProgress"];
    [[NSUserDefaults standardUserDefaults]setObject:[NSNumber numberWithInt:0] forKey:@"finalScore"];
    [[NSUserDefaults standardUserDefaults]setObject:history forKey:@"cityHistory"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    StreetViewController *StreeVC=[[StreetViewController alloc]init];
    [self presentViewController:StreeVC animated:YES completion:^{}];
   }

-(void)findRandomPlace{
    
}

-(void)setCoordinate{
    NSArray *array=[self randomCountryCitiesListWithCountryName:@"!!!"];
    NSUInteger randomIndex = arc4random() % [array count];
    NSString *randomCityName=[array objectAtIndex:randomIndex];
    NSString *randomCityNameURL=[NSString stringWithFormat:@"http://maps.google.com/maps/api/geocode/xml?address=%@&sensor=true",randomCityName];
    
    self.parser=[[XMLParser alloc] loadXMLByURL:randomCityNameURL];
    NSString *city = [[randomCityName componentsSeparatedByString:@"%20"] objectAtIndex:1];
    
    NSString *state = [[randomCityName componentsSeparatedByString:@"%20"] objectAtIndex:2];
    self.parser.cityState = [NSString stringWithFormat:@"%@, %@", city, state];
    
    double southwest_lat=[self.parser.southwest_lat doubleValue];
    double southwest_lng=[self.parser.southwest_lng doubleValue];
    double northeast_lat=[self.parser.northeast_lat doubleValue];
    double northeast_lng=[self.parser.northeast_lng doubleValue];
    double lat   =   [Random randomFloatFrom:southwest_lat to:northeast_lat];
    double lng   =   [Random randomFloatFrom:southwest_lng to:northeast_lng];
    
    coordinatesToGuess.latitude     =   lat;
    coordinatesToGuess.longitude    =   lng;
    NSLog(@"%@",self.parser.address);
    NSLog(@"START LOCATION %.20g,%.20g",lat,lng);
    if (!lat) {
        [self setCoordinate];
    }else{
        NSArray *history= [[NSUserDefaults standardUserDefaults]  objectForKey:@"cityHistory"];
        NSMutableArray *cityHistory=[[NSMutableArray alloc]initWithArray:history];
        [cityHistory addObject:randomCityName];
        
        NSLog(@"%@",cityHistory);
        
        NSArray *new=[NSArray arrayWithArray:cityHistory];
        [[NSUserDefaults standardUserDefaults]setObject:new forKey:@"cityHistory"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }
}

-(CLLocationCoordinate2D)getCoordinate{
    return coordinatesToGuess;
}

-(NSArray*)randomCountryCitiesListWithCountryName:(NSString*)countryName{
    NSString *filePath=[[NSBundle mainBundle]pathForResource:@"USCities" ofType:@"txt"];
    NSArray *array;
    if(filePath){
        NSError *error;
        NSString *cities=[NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
        array = [cities componentsSeparatedByString:@";"];
    }
    return array;
}

//-(IBAction)switchMap
//{
//    true ? [self showStreetView] : [self map]
//}

-(void)showStreetView{
    [self findRandomPlace];
    [self setCoordinate];
    view_ = [GMSPanoramaView panoramaWithFrame:CGRectZero nearCoordinate:coordinatesToGuess radius:2000];
    view_.camera = [GMSPanoramaCamera cameraWithHeading:180 pitch:-10 zoom:0];
    view_.delegate = self;
    view_.orientationGestures = YES;
    view_.navigationGestures = YES;
    view_.navigationLinksHidden = NO;
    view_.streetNamesHidden=YES;
    self.view = view_;
    

    //Buttons
    UIButton *Switch=[[UIButton alloc]initWithFrame:CGRectMake(10, 30, 40, 20)];
    [Switch setTitle:@"Map" forState:UIControlStateNormal];
    [Switch setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    //[Switch primaryStyle];
    [self.view addSubview:Switch];
    [Switch addTarget:self action:@selector(switchView) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *quit=[[UIButton alloc]initWithFrame:CGRectMake(270, 30, 40, 20)];
    [quit setTitle:@"Quit" forState:UIControlStateNormal];
    [quit setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    //[quit primaryStyle];
    [self.view addSubview:quit];
    [quit addTarget:self action:@selector(quitButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    UITapGestureRecognizer *oneFingerTwoTaps =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(oneFingerTwoTaps)];
    [oneFingerTwoTaps setNumberOfTapsRequired:2];
    [oneFingerTwoTaps setNumberOfTouchesRequired:1];
    [[self view] addGestureRecognizer:oneFingerTwoTaps];
    
    NSString *text = [NSString stringWithFormat:@"You walked: %d steps",self.walkCount];
    [self.walkCountLabel setText:text];
    self.walkCountLabel.textColor = [UIColor blackColor];
    self.walkCountLabel.backgroundColor = [UIColor clearColor];
    
    [view_ addSubview:self.walkCountLabel];

    [self gameWillRepeatForFiveTimes];
    [view_ addSubview:self.gamePrograssLable];
    
}

-(void)quitButtonPressed{
    [self dismissViewControllerAnimated:NO completion:^{}];
}


//Following code is MapView

-(IBAction)switchView{
//-(void)switchView{
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:41
                                                            longitude:-87
                                                                 zoom:2];
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.delegate = self;
    self.view = mapView_;
    
    
    UIButton *Switch=[[UIButton alloc]initWithFrame:CGRectMake(10, 30, 45, 20)];
    [Switch setTitle:@"Back" forState:UIControlStateNormal];
    [Switch setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.view addSubview:Switch];
    [Switch addTarget:self action:@selector(backView) forControlEvents:UIControlEventTouchUpInside];
    
    //game instruction
    int gameProgress = [[NSUserDefaults standardUserDefaults]  integerForKey:@"gameProgress"];
    if (gameProgress==1) {
        UIAlertView *mBoxView =[[UIAlertView alloc]initWithTitle:@"Tip" message:@"Long press on the screen to drop a marker \n 1000 is full score!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        mBoxView.alpha=0.1;
        [mBoxView show];
    }
}


- (void)mapView:(GMSMapView *)mapView
didLongPressAtCoordinate:(CLLocationCoordinate2D)coordinate {
    GMSMarker *marker = [[GMSMarker alloc] init];
    [mapView_ clear];
    self.scoreLable.text = nil;
    
    marker.title = [NSString stringWithFormat:@"You guessed location: %.2f,%.2f",
                    coordinate.latitude, coordinate.longitude];
    
    NSArray *gameArray = [NSArray arrayWithObjects:[NSNumber numberWithDouble:coordinate.latitude], [NSNumber numberWithDouble:coordinate.longitude],nil];
    NSArray *coordinatesToGuess = [NSArray arrayWithObjects:[NSNumber numberWithDouble:self.getCoordinate.latitude],[NSNumber numberWithDouble:self.getCoordinate.longitude],nil];;
    
    
    marker.title = [NSString stringWithFormat:@"Your guess"];
    marker.position = coordinate;
    marker.appearAnimation = kGMSMarkerAnimationPop;
    marker.map = mapView_;
    
    
    end = coordinate;
    
    [self.game calculateScore:gameArray
                       second:coordinatesToGuess
                    walkcount:self.walkCount];
    
    //UILabel *scoreLable=[[UILabel alloc]initWithFrame:CGRectMake(90, 90, 180, 40)];
    NSString *text = [NSString stringWithFormat:@"Score is %@",self.game.score];
    [self.scoreLable setText:text];
    self.scoreLable.textColor = [UIColor blackColor];
    self.scoreLable.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:self.scoreLable];
    self.scoreLable.hidden = YES;
    // delete the new marker to the list of markers.
    

    //[self.makeGuess warningStyle];
    [self.view addSubview:_makeGuess];
    [_makeGuess addTarget:self action:@selector(continueButton) forControlEvents:UIControlEventTouchUpInside];
}

-(void)backView{
    //StreetViewController *StreeVC=[[StreetViewController alloc]init];
    //[self dismissViewControllerAnimated:YES completion:^{}];
    self.view = view_;
    
}

-(void)continueButton{
    self.Switch.hidden=YES;
    self.scoreLable.hidden = NO;
	self.makeGuess.hidden=YES;
    [_makeGuess removeFromSuperview];
    
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.icon = [GMSMarker markerImageWithColor:[UIColor blueColor]];
//    marker.title = [NSString stringWithFormat:@"xx\nRight location: %.2f,%.2f",
//                    coordinatesToGuess.latitude, coordinatesToGuess.longitude];
    marker.title = self.parser.address;
    marker.position = coordinatesToGuess;
    marker.appearAnimation = kGMSMarkerAnimationPop;
    marker.map = mapView_;
    
    //draw a line between two markers
    CLLocationCoordinate2D start = { (coordinatesToGuess.latitude), (coordinatesToGuess.longitude) };
    GMSMutablePath *path = [GMSMutablePath path];
    [path addCoordinate:start];
    [path addCoordinate:end];
    GMSPolyline *polyline = [GMSPolyline polylineWithPath:path];
    polyline.strokeWidth = 2.f;
    polyline.geodesic = YES;
    polyline.strokeColor = [UIColor redColor];
    polyline.map = mapView_;
    
    
    UIView *clearView=[[UIView alloc]init];
	clearView.backgroundColor=[UIColor clearColor];
	[clearView setFrame:self.view.frame];
	[self.view addSubview:clearView];
    
    UIButton *continueButton=[[UIButton alloc]initWithFrame:CGRectMake(200, 30, 100, 20)];
    [continueButton setTitle:@"Continue" forState:UIControlStateNormal];
    [continueButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:continueButton];
    [continueButton addTarget:self action:@selector(initStreetView) forControlEvents:UIControlEventTouchUpInside];
	
    
}

-(void)initStreetView{
    StreetViewController *StreeVC=[[StreetViewController alloc]init];
    [self presentViewController:StreeVC animated:YES completion:^{}];
}

-(void)viewDidDisappear:(BOOL)animated{
    NSNumber *score = [[NSUserDefaults standardUserDefaults]  objectForKey:@"finalScore"];
    float value = [score floatValue];
    float value2 = [self.game.score floatValue];
    
    float sum=value+value2;
    
    [[NSUserDefaults standardUserDefaults]setObject:[NSNumber numberWithFloat:sum] forKey:@"finalScore"];
    [[NSUserDefaults standardUserDefaults] synchronize];

}

-(void)button1{
    NSArray *history= [[NSUserDefaults standardUserDefaults]  objectForKey:@"cityHistory"];
    NSString *name=[history objectAtIndex:0];
    NSString *url=[[NSString alloc]initWithFormat:@"http://en.m.wikipedia.org/w/index.php?search=%@&fulltext=search",name];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}
-(void)button2{
    NSArray *history= [[NSUserDefaults standardUserDefaults]  objectForKey:@"cityHistory"];
    NSString *name=[history objectAtIndex:1];
    NSString *url=[[NSString alloc]initWithFormat:@"http://en.m.wikipedia.org/w/index.php?search=%@&fulltext=search",name];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}
-(void)button3{
    NSArray *history= [[NSUserDefaults standardUserDefaults]  objectForKey:@"cityHistory"];
    NSString *name=[history objectAtIndex:2];
    NSString *url=[[NSString alloc]initWithFormat:@"http://en.m.wikipedia.org/w/index.php?search=%@&fulltext=search",name];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}
-(void)button4{
    NSArray *history= [[NSUserDefaults standardUserDefaults]  objectForKey:@"cityHistory"];
    NSString *name=[history objectAtIndex:3];
    NSString *url=[[NSString alloc]initWithFormat:@"http://en.m.wikipedia.org/w/index.php?search=%@&fulltext=search",name];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}
-(void)button5{
    NSArray *history= [[NSUserDefaults standardUserDefaults]  objectForKey:@"cityHistory"];
    NSString *name=[history objectAtIndex:4];
    NSString *url=[[NSString alloc]initWithFormat:@"http://en.m.wikipedia.org/w/index.php?search=%@&fulltext=search",name];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}
@end
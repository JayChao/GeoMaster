
//  StreetViewController.m
//  Geo Master
//
//  Created by Shufang Han on 14-4-6.
//  Copyright (c) 2014年 ios.uiowa. All rights reserved.
//

#import "StreetViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import "XMLParser.h"
#import "Random.h"
#import "UIButton+Bootstrap.h"
#import "GeoGame.h"
#import "MainViewController.h"

@interface StreetViewController ()<GMSPanoramaViewDelegate,GMSMapViewDelegate,UIGestureRecognizerDelegate>
@property (strong,nonatomic)NSMutableString *randomCityName;
@property XMLParser *parser;
@property UILabel *scoreLable;
@property (nonatomic) GeoGame *game;
@property (nonatomic) MainViewController *main;

@property UILabel *walkCountLabel;
@property UILabel *gamePrograssLable;
@property UILabel *finalResultLabel;
@property UIButton *makeGuess;

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
    
    self.game = [[GeoGame alloc]init];
    
    self.gamePrograssLable = [[UILabel alloc] initWithFrame:CGRectMake(90, 50, 180, 40)];
    self.scoreLable=[[UILabel alloc]initWithFrame:CGRectMake(90, 90, 180, 40)];
    self.walkCountLabel=[[UILabel alloc]initWithFrame:CGRectMake(90, 90, 180, 40)];
    self.finalResultLabel=[[UILabel alloc]initWithFrame:CGRectMake(90, 230, 300, 90)];

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
       NSString *text = [NSString stringWithFormat:@"Your score is:%@ \n full score is 5000", score];
       
       [self.finalResultLabel setText:text];
       self.finalResultLabel.textColor = [UIColor blackColor];
       self.finalResultLabel.backgroundColor = [UIColor clearColor];
       
       UIButton *playAgain=[[UIButton alloc]initWithFrame:CGRectMake(120, 300, 90, 90)];
       //[playAgain setCenter:CGPointMake(self.view.frame.size.width/2.0, self.view.frame.size.height/3.0*2)];
       [playAgain setTitle:@"playAgain" forState:UIControlStateNormal];
       [playAgain setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
       //[quit primaryStyle];
       self.view=resultView;
       [self.view addSubview:playAgain];
       [playAgain addTarget:self action:@selector(playAgain) forControlEvents:UIControlEventTouchUpInside];
       
       self.view.backgroundColor=[UIColor colorWithRed:0.800 green:0.600 blue:0.400 alpha:0.900];
       
       [resultView addSubview:self.finalResultLabel];
       

   }
}

-(void)playAgain{
    
    [[NSUserDefaults standardUserDefaults]setObject:[NSNumber numberWithInt:0] forKey:@"gameProgress"];
    [[NSUserDefaults standardUserDefaults]setObject:[NSNumber numberWithInt:0] forKey:@"finalScore"];
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

-(void)showStreetView{
    [self findRandomPlace];
    [self setCoordinate];
    view_ = [GMSPanoramaView panoramaWithFrame:CGRectZero nearCoordinate:coordinatesToGuess radius:2000];
    view_.camera = [GMSPanoramaCamera cameraWithHeading:180 pitch:-10 zoom:0];
    view_.delegate = self;
    view_.orientationGestures = YES;
    view_.navigationGestures = YES;
    view_.navigationLinksHidden = YES;
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

-(void)switchView{
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
    
    self.makeGuess=[[UIButton alloc]initWithFrame:CGRectMake(200, 30, 100, 20)];
    [_makeGuess setTitle:@"MakeGuess" forState:UIControlStateNormal];
    [_makeGuess setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:_makeGuess];
    [_makeGuess addTarget:self action:@selector(continueButton) forControlEvents:UIControlEventTouchUpInside];
    
    
   
    
    
    
}

-(void)backView{
    //StreetViewController *StreeVC=[[StreetViewController alloc]init];
    //[self dismissViewControllerAnimated:YES completion:^{}];
    self.view = view_;
    
}

-(void)continueButton{
    self.scoreLable.hidden = NO;
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
@end
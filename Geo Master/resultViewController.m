//
//  resultViewController.m
//  Geo Master
//
//  Created by Chao, Yongqi on 4/20/14.
//  Copyright (c) 2014 ios.uiowa. All rights reserved.
//

#import "resultViewController.h"
#import "MainViewController.h"

@interface resultViewController ()
@property (strong, nonatomic) IBOutlet UIButton *PlayAgain;
@end

@implementation resultViewController

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
    
    UIButton *playAgain=[[UIButton alloc]initWithFrame:CGRectMake(180, 180, 180, 20)];
    [playAgain setTitle:@"playAgain" forState:UIControlStateNormal];
    [playAgain setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    //[quit primaryStyle];
    [self.view addSubview:playAgain];
    [playAgain addTarget:self action:@selector(playAgain) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)playAgain{
    MainViewController *openVC = [[MainViewController alloc]init];
    [self presentViewController:openVC animated:YES completion:^{}];
}

@end

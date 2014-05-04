//
//  ChallengeViewController.m
//  Geo Master
//
//  Created by HanShufang on 14-5-1.
//  Copyright (c) 2014年 ios.uiowa. All rights reserved.
//

#import "ChallengeViewController.h"
#import "PAImageView.h"
#import "StreetViewController.h"
#import "MainViewController.h"
#import "ChallengeGameViewController.h"
@interface ChallengeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
//@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation ChallengeViewController



#pragma mark - RPSlidingMenuViewController

-(NSInteger)numberOfItemsInSlidingMenu{

    // 10 for demo purposes, typically the count of some array
    return 20;
}

- (void)customizeCell:(RPSlidingMenuCell *)slidingMenuCell forRow:(NSInteger)row{


    // alternate for demo.  Simply set the properties of the passed in cell
    if (row%7 == 0) {
        slidingMenuCell.textLabel.text = @"New York City";
        slidingMenuCell.detailTextLabel.text = @"The Big Apple";
        //slidingMenuCell.detailTextLabel.textColor=[UIColor colorWithWhite:0.800 alpha:1.000];
        slidingMenuCell.backgroundImageView.image = [UIImage imageNamed:@"newyork320*210"];
    }else if (row%7 == 1){
        
        slidingMenuCell.textLabel.text = @"Chicago";
        slidingMenuCell.detailTextLabel.text = @"Windy Cty";
       // slidingMenuCell.detailTextLabel.textColor=[UIColor whiteColor];
        slidingMenuCell.backgroundImageView.image = [UIImage imageNamed:@"chicago320*210"];
    }else if (row%7 == 2){
        
        slidingMenuCell.textLabel.text = @"Los Angeles";
        slidingMenuCell.detailTextLabel.text = @"City of Angels";
       // slidingMenuCell.detailTextLabel.textColor=[UIColor colorWithWhite:0.400 alpha:1.000];
        slidingMenuCell.backgroundImageView.image = [UIImage imageNamed:@"losangeles320*210"];
    }else if (row%7 == 3){
        
        slidingMenuCell.textLabel.text = @"Seattle";
        slidingMenuCell.detailTextLabel.text = @"The Emerald City";
        slidingMenuCell.backgroundImageView.image = [UIImage imageNamed:@"seattle320*210"];
    }else if (row%7 == 4){
        
        slidingMenuCell.textLabel.text = @"Miami";
        slidingMenuCell.detailTextLabel.text = @"The Magic City";
        slidingMenuCell.backgroundImageView.image = [UIImage imageNamed:@"miami320*210"];
    }else if (row%7 == 5){
        
        slidingMenuCell.textLabel.text = @"Washington DC";
        slidingMenuCell.detailTextLabel.text = @"Capital Of America";
        slidingMenuCell.backgroundImageView.image = [UIImage imageNamed:@"washington320*210"];
    }else if (row%7 == 6){
    
        slidingMenuCell.textLabel.text = @"Quit";
        slidingMenuCell.detailTextLabel.text = @"Back to main menu";
        slidingMenuCell.backgroundImageView.image = [UIImage imageNamed:@"white"];
        
    }
}

- (void)slidingMenu:(RPSlidingMenuViewController *)slidingMenu didSelectItemAtRow:(NSInteger)row{
    
    [super slidingMenu:slidingMenu didSelectItemAtRow:row];
    
    // when a row is tapped do some action

    [[NSUserDefaults standardUserDefaults]setInteger:row%7 forKey:@"challengeCityIndex"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    


    ChallengeGameViewController *gameVC=[[ChallengeGameViewController alloc]init];
    [self presentViewController:gameVC animated:YES completion:^{}];

}

-(void)viewDidAppear:(BOOL)animated{
    UIView *new=[[UIView alloc]init];
    UIView *temp=self.view;
    self.view=new;
    [temp setFrame:CGRectMake(0, 50, 320, self.view.frame.size.height)];
    [self.view addSubview:temp];
    UINavigationBar *bar=[[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    [self.view addSubview:bar];
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                                                    style:UIBarButtonItemStyleDone target:self action:@selector(btnClicked:)];
    UINavigationItem *item = [[UINavigationItem alloc] initWithTitle:@"Choose one City"];
    item.rightBarButtonItem = rightButton;
    item.hidesBackButton = YES;
    [bar pushNavigationItem:item animated:NO];


}

-(void) btnClicked:(id)sender
{
    [self dismissViewControllerAnimated:NO completion:^{}];
}


@end

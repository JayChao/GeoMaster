//
//  ChallengeViewController.m
//  Geo Master
//
//  Created by HanShufang on 14-5-1.
//  Copyright (c) 2014年 ios.uiowa. All rights reserved.
//

#import "ChallengeViewController.h"
#import "PAImageView.h"

@interface ChallengeViewController ()

@end

@implementation ChallengeViewController

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
    PAImageView *avatarView = [[PAImageView alloc]initWithFrame:CGRectMake((self.view.bounds.size.width-100)/2, (self.view.bounds.size.height-100)/2, 100, 100) backgroundProgressColor:[UIColor whiteColor] progressColor:[UIColor lightGrayColor]];
    [self.view addSubview:avatarView];
    [avatarView setImageURL:@"https://fedea106-a-62cb3a1a-s-sites.googlegroups.com/site/georaphymaster/pic/newyork1.0.jpg"];
}



@end

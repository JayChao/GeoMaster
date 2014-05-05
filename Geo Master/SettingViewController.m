//
//  SettingViewController.m
//  Geo Master
//
//  Created by Chao, Yongqi on 5/4/14.
//  Copyright (c) 2014 ios.uiowa. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()
@property (strong, nonatomic) IBOutlet UISwitch *BGMSwitch;
@property NSInteger OnOff;
@end

@implementation SettingViewController


- (IBAction)BGMSwitch:(UISwitch *)sender {
    BOOL test=sender.on;
    if (test) {
        self.OnOff=1;
    }else{
        self.OnOff=2;
    }

}


- (void)viewDidLoad
{
    [super viewDidLoad];

    self.OnOff=[[NSUserDefaults standardUserDefaults]  integerForKey:@"BGMOnOff"];

    if(self.OnOff==1){
        self.BGMSwitch.on = YES;
    }else{
        self.BGMSwitch.on=NO;
    }
}
-(void)viewDidDisappear:(BOOL)animated{
    [[NSUserDefaults standardUserDefaults]setInteger:self.OnOff forKey:@"BGMOnOff"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end

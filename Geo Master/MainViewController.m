//
//  MainViewController.m
//  Geo Master
//
//  Created by Jaime on 4/8/14.
//  Copyright (c) 2014 ios.uiowa. All rights reserved.
//

#import "MainViewController.h"
#import "StreetViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import "FSAudioStream.h"
#import "UIButton+Bootstrap.h"


@interface MainViewController ()
@property (strong, nonatomic) IBOutlet UIButton *StartButton;
@property (strong, nonatomic) IBOutlet UIButton *SettingsButton;
@property (strong, nonatomic) IBOutlet UIButton *ScoreButton;
@property (strong, nonatomic) IBOutlet UIButton *BackButton;
@property (strong, nonatomic) IBOutlet UIButton *GuideButton;
@property (strong, nonatomic) IBOutlet FBProfilePictureView *profilePictureView;
@end

@implementation MainViewController{
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
    }
    return self;
}
- (IBAction)startButtonPressed:(UIButton *)sender {

    [[NSUserDefaults standardUserDefaults]setObject:[NSNumber numberWithInt:0] forKey:@"gameProgress"];
    [[NSUserDefaults standardUserDefaults]setObject:[NSNumber numberWithInt:0] forKey:@"finalScore"];
    [[NSUserDefaults standardUserDefaults] synchronize];


    StreetViewController *StreeVC=[[StreetViewController alloc]init];
    [self presentViewController:StreeVC animated:YES completion:^{}];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    FBLoginView *loginView = [[FBLoginView alloc] initWithReadPermissions:@[@"basic_info"]];
    loginView.delegate = self;
    loginView.frame = CGRectOffset(loginView.frame, (self.view.center.x - (loginView.frame.size.width / 2)), self.view.center.y);
    loginView.center=CGPointMake(self.view.frame.size.width/2.0, self.view.frame.size.height/4.0*3);
    [self.view addSubview:loginView];
    
    _audioStream = [[FSAudioStream alloc] init];
    [_audioStream playFromURL:[NSURL URLWithString:@"http://sites.google.com/site/georaphymaster/bgm/03%20Morning%20air%20%E6%99%A8%E9%9B%BE.mp3"]];
    [_audioStream stop];
    self.view.backgroundColor=[UIColor colorWithRed:0.800 green:0.600 blue:0.400 alpha:1.000];
    
    [self.StartButton primaryStyle];
    [self.SettingsButton primaryStyle];
    [self.ScoreButton primaryStyle];
    [self.BackButton primaryStyle];
    [self.GuideButton primaryStyle];

}


// This method will be called when the user information has been fetched
- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
                            user:(id<FBGraphUser>)user {
    self.profilePictureView.profileID = user.id;
}

// Logged-in user experience
- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView {
}

// Logged-out user experience
- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView {
    self.profilePictureView.profileID = nil;
}

// Handle possible errors that can occur during login
- (void)loginView:(FBLoginView *)loginView handleError:(NSError *)error {
    NSString *alertMessage, *alertTitle;
    
    // If the user should perform an action outside of you app to recover,
    // the SDK will provide a message for the user, you just need to surface it.
    // This conveniently handles cases like Facebook password change or unverified Facebook accounts.
    if ([FBErrorUtility shouldNotifyUserForError:error]) {
        alertTitle = @"Facebook error";
        alertMessage = [FBErrorUtility userMessageForError:error];
        
        // This code will handle session closures that happen outside of the app
        // You can take a look at our error handling guide to know more about it
        // https://developers.facebook.com/docs/ios/errors
    } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryAuthenticationReopenSession) {
        alertTitle = @"Session Error";
        alertMessage = @"Your current session is no longer valid. Please log in again.";
        
        // If the user has cancelled a login, we will do nothing.
        // You can also choose to show the user a message if cancelling login will result in
        // the user not being able to complete a task they had initiated in your app
        // (like accessing FB-stored information or posting to Facebook)
    } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryUserCancelled) {
        NSLog(@"user cancelled login");
        
        // For simplicity, this sample handles other errors with a generic message
        // You can checkout our error handling guide for more detailed information
        // https://developers.facebook.com/docs/ios/errors
    } else {
        alertTitle  = @"Something went wrong";
        alertMessage = @"Please try again later.";
        NSLog(@"Unexpected error:%@", error);
    }
    
    if (alertMessage) {
        [[[UIAlertView alloc] initWithTitle:alertTitle
                                    message:alertMessage
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



@end

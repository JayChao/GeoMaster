//
//  GeoAppDelegate.m
//  Geo Master
//
//  Created by Chao, Yongqi on 4/6/14.
//  Copyright (c) 2014 ios.uiowa. All rights reserved.
//

#import "GeoAppDelegate.h"
#import <GoogleMaps/GoogleMaps.h>
#import <FacebookSDK/FacebookSDK.h>
#import "GeoRecord.h"
#import "GeoRecordCollection.h"

#import "OpenViewController.h"
#import "MainViewController.h"
#import "GeoHighScoresViewController.h"

@implementation GeoAppDelegate
{
    GeoRecordCollection* _recordCollection;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [FBLoginView class];
    [GMSServices provideAPIKey:@"AIzaSyCtGILRnz4sF78fb67SnfIRIvwi4U1e_XI"];
    
//    _recordCollection = [[GeoRecordCollection alloc] init];
//    
//    GeoRecord* record1 = [[GeoRecord alloc] init];
//    record1.playerName = [NSString stringWithFormat:@"Katniss Everdeen"];
//    record1.score = [NSNumber numberWithDouble:45.67];
//    
//    GeoRecord* record2 = [[GeoRecord alloc] init];
//    record2.playerName = [NSString stringWithFormat:@"Peeta Mellark"];
//    record2.score = [NSNumber numberWithDouble:12.98];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application
             openURL:(NSURL *)url
   sourceApplication:(NSString *)sourceApplication
          annotation:(id)annotation {
    
    // Call FBAppCall's handleOpenURL:sourceApplication to handle Facebook app responses
    BOOL wasHandled = [FBAppCall handleOpenURL:url sourceApplication:sourceApplication];
    
    // You can add your app-specific url handling code here if needed
    
    return wasHandled;
}

@end

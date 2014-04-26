//
//  MainViewController.h
//  Geo Master
//
//  Created by Jaime on 4/8/14.
//  Copyright (c) 2014 ios.uiowa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
@class FSAudioStream;
@interface MainViewController : UIViewController <FBLoginViewDelegate>{
    FSAudioStream *_audioStream;
}

@end

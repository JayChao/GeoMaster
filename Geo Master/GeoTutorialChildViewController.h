//
//  GeoTutorialChildViewController.h
//  Geo Master
//
//  Created by Volker, Joseph on 4/29/14.
//  Copyright (c) 2014 ios.uiowa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GeoTutorialChildViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *maptypeView;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (assign, nonatomic) NSInteger index;

@end

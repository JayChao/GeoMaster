//
//  GeoHighScoreTableCell.h
//  Geo Master
//
//  Created by Volker, Joseph on 4/30/14.
//  Copyright (c) 2014 ios.uiowa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GeoHighScoreTableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *recordImage;
@property (weak, nonatomic) IBOutlet UILabel *playerNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@end

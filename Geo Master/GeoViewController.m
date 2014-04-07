#import "GeoViewController.h"
#import "StreetViewController.h"

@interface GeoViewController ()

@end

@implementation GeoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)press:(UIButton *)sender {
    StreetViewController *gameVC=[[StreetViewController alloc]init];
    [self presentViewController:gameVC animated:NO completion:^{}];

}

-(NSString *)returnFormatString:(NSString *)str
{
    return [str stringByReplacingOccurrencesOfString:@" " withString:@" "];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  SearchPageViewController.m
//  WashUHack
//
//  Created by Vincewang on 9/19/15.
//
//

#import "SearchPageViewController.h"

@interface SearchPageViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *checkAtt;
@property (weak, nonatomic) IBOutlet UIImageView *checkRes;
@property (weak, nonatomic) IBOutlet UIImageView *checkHot;
@property (weak, nonatomic) IBOutlet UITextField *searchtext;

@end

@implementation SearchPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.checkRes.hidden=true;
    self.checkHot.hidden=true;
    self.choice=@"attractions";
    // Do any additional setup after loading the view.
}

- (IBAction)att:(UIButton *)sender {
    self.checkRes.hidden=true;
    self.checkHot.hidden=true;
    self.checkAtt.hidden=false;
    self.choice=@"attractions";
}
- (IBAction)res:(UIButton *)sender {
    self.checkRes.hidden=false;
    self.checkHot.hidden=true;
    self.checkAtt.hidden=true;
    self.choice=@"restaurants";
}

- (IBAction)hot:(UIButton *)sender {
    self.checkRes.hidden=true;
    self.checkHot.hidden=false;
    self.checkAtt.hidden=true;
    self.choice=@"hotels";
}
- (IBAction)search:(UITextField *)sender {
    NSLog(@"end");
    [UtilsTripAdvisor searchLocationsByTerm:self.searchtext.text withCategory:self.choice completionHandler:^(NSArray *loc, NSError *error){
        if (!error) {
            [self performSegueWithIdentifier:@"results" sender:loc];
        } else {
            NSLog(@"%@", error);
        }
    }];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([[segue identifier] isEqualToString:@"results"]){
        SearchResultsViewController *nextpage=(SearchResultsViewController *)[segue destinationViewController];
        nextpage.loc=sender;
    }
}


@end

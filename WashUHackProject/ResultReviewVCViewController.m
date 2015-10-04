//
//  ResultReviewVCViewController.m
//  WashUHack
//
//  Created by Vincewang on 9/20/15.
//
//

#import "ResultReviewVCViewController.h"

@interface ResultReviewVCViewController ()

@end

@implementation ResultReviewVCViewController


NSURL *url;
NSInteger i;
- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.parseClassName = @"UserVideo";
        self.pullToRefreshEnabled = YES;
        self.paginationEnabled = YES;
        self.objectsPerPage = 20;
    }
    return self;
}


- (void)viewDidLoad {
    self.videos=[[NSMutableArray alloc]init];
    self.urls=[[NSMutableArray alloc]init];
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (PFQuery *)queryForTable {
    
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    
    PFUser *currentUser = [PFUser currentUser];
    // NSLog(@"Before: %lu",query.countObjects);
    //NSLog(@"id is %@",self.id_);
    //NSNumber* temp=[[NSNumber alloc]initWithInteger:self.id_];
    [query whereKey:@"location_id" equalTo:self.id_];
    
    [query orderByDescending:@"createdAt"];
    NSLog(@"%lu",query.countObjects);
    return query;
}


#pragma mark - Table view data source

/*- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
 return 1;
 }
 
 - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
 #warning Incomplete implementation, return the number of rows
 return 3;
 }*/


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object{
    static NSString *CellIdentifier = @"Cell";
    
    PFTableViewCell *cell = (PFTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[PFTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:19.0];
    }
    cell.textLabel.text=object[@"username"];
    Video* tempVideo=[[Video alloc]initFromPFObject:object];
    NSData *data = [NSData dataWithContentsOfURL:[[NSURL alloc]initWithString:((PFFile*)object[@"thumbnail"]).url]];
    cell.imageView.image=[UIImage imageWithData:data];
    [self.urls addObject:[[NSURL alloc]initWithString:((PFFile*)object[@"video"]).url]];
    [self.videos addObject:tempVideo];
    [self.pfObjects addObject:object];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
  /*  self.videoController=[[MPMoviePlayerController alloc] initWithContentURL:_urls[indexPath.row]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayBackDidFinish:) name:MPMoviePlayerPlaybackDidFinishNotification object:self.videoController];
    self.videoController.controlStyle = MPMovieControlStyleDefault;
    self.videoController.shouldAutoplay = YES;
    [self.view addSubview:self.videoController.view];
    [self.videoController setFullscreen:YES animated:YES];*/
    i=indexPath.row;
    [self performSegueWithIdentifier:@"singlevideo" sender:self.urls[indexPath.row]];
}

- (void) moviePlayBackDidFinish:(NSNotification *)notification {
    MPMoviePlayerController *player = [notification object];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:player];
    
    if ([player respondsToSelector:@selector(setFullscreen:animated:)]) {
        [player.view removeFromSuperview];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSLog(@"id is: %@",sender);
    if([[segue identifier] isEqualToString:@"singlevideo"]){
        SingleVideoVC *nextpage=(SingleVideoVC *)[segue destinationViewController];
        nextpage.videoURL=[self.urls objectAtIndex:i];
        nextpage.myvideo=self.videos[i];
        nextpage.object=self.pfObjects[i];
    }
}
@end
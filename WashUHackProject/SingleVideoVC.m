//
//  SingleVideoVC.m
//  WashUHack
//
//  Created by Vincewang on 9/20/15.
//
//

#import "SingleVideoVC.h"

@interface SingleVideoVC ()
@property (weak, nonatomic) IBOutlet UITextView *mytext;
@property (weak, nonatomic) IBOutlet UITextField *mycomment;

@end

@implementation SingleVideoVC

@synthesize videoURL;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.videoController = [[MPMoviePlayerController alloc] init];
    
    [self.videoController setContentURL:self.videoURL];
    [self.videoController.view setFrame:CGRectMake (0, 0, 320, 320)];
    [self.view addSubview:self.videoController.view];
    
    [self.videoController play];
    NSString *all;
    for(Comment *currcomment in self.myvideo.comments){
        all=[all stringByAppendingString:currcomment.username];
        all=[all stringByAppendingString:@":"];
        all=[all stringByAppendingString:currcomment.content];
        all=[all stringByAppendingString:@"\n\n"];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)videoPlayBackDidFinish:(NSNotification *)notification {
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    
    // Stop the video player and remove it from view
    [self.videoController stop];
    [self.videoController.view removeFromSuperview];
    self.videoController = nil;
    
    // Display a message
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"Video Playback" message:@"Just finished the video playback. The video is now removed." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    
}
- (IBAction)uploadcomment:(UITextField *)sender {
    Comment *uploadcomment=[[Comment alloc]init];
    uploadcomment.username=[[PFUser currentUser] username];
    uploadcomment.content=self.mycomment.text;
    uploadcomment.videoID=self.myvideo.id_;
    [uploadcomment saveInBackGroundWithBlock: ^(BOOL succeeded, NSError *error){
        if (succeeded) {
            NSLog(@"Save succeeded!");
        } else {
            NSLog(@"%@", error.description);
        }
    }];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

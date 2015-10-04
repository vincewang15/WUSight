//
//  TakeVideoViewController.m
//  WashUHack
//
//  Created by Vincewang on 9/19/15.
//
//

#import "TakeVideoViewController.h"

@interface TakeVideoViewController ()


@property (weak, nonatomic) IBOutlet UITextView *mytext;
@property (weak, nonatomic) IBOutlet UITextField *filename;

@end

@implementation TakeVideoViewController


- (void) viewDidLoad {
    [super viewDidLoad];
    self.isTaken=true;
    self.backbutton.hidden=true;
    [self.backbutton setTitle:@"Cancel" forState:UIControlStateNormal];
}

-(void)viewWillAppear:(BOOL)animated{
    if(self.isTaken){
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.mediaTypes = [[NSArray alloc] initWithObjects:(NSString *) kUTTypeMovie, nil];
        
        [self presentViewController:picker animated:YES completion:NULL];
    }
    }
}
- (IBAction)backtovideo:(UIButton *)sender {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        self.mytext.text=@"";
        self.isTaken=true;
        self.backbutton.hidden=true;
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.mediaTypes = [[NSArray alloc] initWithObjects:(NSString *) kUTTypeMovie, nil];
        [picker setVideoMaximumDuration:10.0f];
        [self presentViewController:picker animated:YES completion:NULL];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    
    self.isTaken=false;
    NSLog(@"finished take image");
    self.backbutton.hidden=false;
    self.videoURL = info[UIImagePickerControllerMediaURL];
    [self dismissViewControllerAnimated:YES completion:nil];
    // test for save object with block
  
    self.videoController = [[MPMoviePlayerController alloc] init];
    
    [self.videoController setContentURL:self.videoURL];
    [self.videoController.view setFrame:CGRectMake (0, 300, 320, 180)];
    [self.view addSubview:self.videoController.view];
    
    [self.videoController play];
    [PFGeoPoint geoPointForCurrentLocationInBackground:^(PFGeoPoint *geoPoint, NSError *error) {
        if (!error) {
            [UtilsTripAdvisor searchNearLocationByGeoPoint:geoPoint andCategory:@"restaurants" completionHandler:^(Location *loc, NSError *error) {
                if (!error) {
                   [self.mytext setFont:[UIFont systemFontOfSize:14.0]];
                    NSString *temp=@"";
                    temp=[temp stringByAppendingString:@"#"];
                    temp=[temp stringByAppendingString:loc.name];
                    temp=[temp stringByAppendingString:@"\n"];
                    self.mytext.text=temp;
                } else {
                    NSLog(@"%@", error);
                }
            }];
        } else {
            NSLog(@"%@",error);
        }
    }];

    
}

- (void) imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.tabBarController setSelectedIndex:0];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textView:(UITextView *)txtView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if( [text rangeOfCharacterFromSet:[NSCharacterSet newlineCharacterSet]].location == NSNotFound ) {
        return YES;
    }
    
    [txtView resignFirstResponder];
    return NO;
}

- (IBAction)submit:(UIButton *)sender {
    self.isTaken=true;
    self.videoObj = [[Video alloc] init];
    self.videoObj.video = [Video videoFileWithContentsOfURL:self.videoURL];
    self.videoObj.thumbnail = [Video thumbnailFirstFrameOfURL:self.videoURL];
    self.videoObj.filename=self.filename.text;
    
    [PFGeoPoint geoPointForCurrentLocationInBackground:^(PFGeoPoint *geoPoint, NSError *error) {
        if (!error) {
            self.videoObj.geo = geoPoint;
            [UtilsTripAdvisor searchNearLocationByGeoPoint:geoPoint andCategory:@"restaurants" completionHandler:^(Location *loc, NSError *error) {
                if (!error) {
                    NSInteger *temp=[loc.id_ integerValue];
                    NSNumber* temp2=[[NSNumber alloc]initWithInteger:temp];
                    
                    self.videoObj.location_id=temp2;
                    [self.videoObj saveInBackGroundWithBlock:^(BOOL succeeded, NSError *error){
                        if (succeeded) {
                            NSLog(@"Save succeeded!");
                        } else {
                            NSLog(@"%@", error.description);
                        }
                    }];
                    
                    
                } else {
                    NSLog(@"%@", error);
                }
            }];
        } else {
            NSLog(@"%@",error);
        }
    }];
    
    [self.tabBarController setSelectedIndex:0];
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

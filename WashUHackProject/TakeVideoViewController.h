//
//  TakeVideoViewController.h
//  WashUHack
//
//  Created by Vincewang on 9/19/15.
//
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <MediaPlayer/MediaPlayer.h>
#import "Video.h"
#import "UtilsTripAdvisor.h"

@interface TakeVideoViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate,UITextViewDelegate>

@property (strong, nonatomic) NSURL *videoURL;
@property (strong, nonatomic) MPMoviePlayerController *videoController;
@property (weak, nonatomic) IBOutlet UIButton *backbutton;
@property (nonatomic) BOOL isTaken;
@property (strong,nonatomic) Video* videoObj;
@end

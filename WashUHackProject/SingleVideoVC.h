//
//  SingleVideoVC.h
//  WashUHack
//
//  Created by Vincewang on 9/20/15.
//
//

#import <UIKit/UIKit.h>
#import "Video.h"
#import <ParseUI/ParseUI.h>
#import <Parse/Parse.h>
#import <MediaPlayer/MediaPlayer.h>
#import "Comment.h"

@interface SingleVideoVC : UIViewController

@property(nonatomic,strong) Video* myvideo;
@property (strong, nonatomic) NSURL *videoURL;
@property (strong, nonatomic) PFObject *object;
@property (strong, nonatomic) MPMoviePlayerController *videoController;
@end

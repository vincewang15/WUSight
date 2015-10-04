//
//  myMain.h
//  WashUHack
//
//  Created by Vincewang on 9/19/15.
//
//

#import <UIKit/UIKit.h>
#import <ParseUI/ParseUI.h>
#import <Parse/Parse.h>
#import <MediaPlayer/MediaPlayer.h>
#import "Video.h"
#import <UtilsTripAdvisor.h>
@interface myMain : PFQueryTableViewController

@property (strong, nonatomic) MPMoviePlayerController *videoController;
@property (strong, nonatomic) NSMutableArray* videos;
@property (strong, nonatomic) NSMutableArray* urls;
@end

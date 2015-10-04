//
//  reviewViewController.h
//  WashUHack
//
//  Created by Vincewang on 9/20/15.
//
//

#import <ParseUI/ParseUI.h>
#import <ParseUI/ParseUI.h>
#import <Parse/Parse.h>
#import <MediaPlayer/MediaPlayer.h>
#import "Video.h"
#import <UtilsTripAdvisor.h>


@interface reviewViewController : PFQueryTableViewController

@property (strong, nonatomic) MPMoviePlayerController *videoController;
@property (strong, nonatomic) NSMutableArray* videos;
@property (strong, nonatomic) NSMutableArray* urls;
@property (strong, nonatomic) NSMutableArray* pfObjects;
@property (strong,nonatomic) UISearchBar *mysearch;
@end

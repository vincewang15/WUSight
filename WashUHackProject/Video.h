//
//  Video.h
//  WashUHack
//
//  Created by Vincewang on 9/20/15.
//
//
#import <Foundation/Foundation.h>
#import <parse/parse.h>
#import <MediaPlayer/MediaPlayer.h>
#import "Comment.h"

@interface Video : NSObject

#define USERVIDEO_DB    @"UserVideo"
#define COMMENT_DB      @"Comment"

@property (nonatomic, strong) NSString *id_;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) NSNumber *location_id;
@property (nonatomic, strong) PFGeoPoint *geo;
@property (nonatomic, strong) PFFile *video;
@property (nonatomic, strong) PFFile *thumbnail;
@property (nonatomic, strong) NSString *filename;
@property (nonatomic, strong) NSMutableArray *comments; // comments for this video

-(id)initFromPFObject: (PFObject *)object;
-(void) retrieveCommentsInBackGround: (void(^)(NSError *error)) completionHandler;
-(void) saveInBackGroundWithBlock:(void (^)(BOOL succeeded, NSError *error))completionHandler;
+(PFFile *) videoFileWithContentsOfURL:(NSURL *)url;
+(PFFile *) thumbnailFirstFrameOfURL:(NSURL *)url;
@end


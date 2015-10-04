//
//  Video.m
//  WashUHack
//
//  Created by Vincewang on 9/20/15.
//
//

#import "Video.h"

@interface Video ()
@end

@implementation Video
@synthesize username;
@synthesize location_id;
@synthesize geo;
@synthesize date;
@synthesize video;
@synthesize thumbnail;
@synthesize id_;

@synthesize comments;

-(id)init {
    self = [super init];
    if (self) {
        self.comments = [[NSMutableArray alloc] init];
    }
    return self;
}

-(id)initFromPFObject: (PFObject *)object {
    self = [super init];
    if (self) {
        [self _parsePFObject:object];
    }
    return self;
}

-(void) saveInBackGroundWithBlock:(void (^)(BOOL succeeded, NSError *error))completionHandler {
    if (!self.video || !self.thumbnail || !self.location_id) { // error check, generate an error and return
        NSMutableDictionary *details = [NSMutableDictionary dictionary];
        [details setValue:@"Video & Thumbnail & Location are required!" forKey:NSLocalizedDescriptionKey];
        NSError *error =[NSError errorWithDomain:@"Video" code:200 userInfo:details];
        completionHandler(NO, error);
        return;
    }
    
    // now we can save to the cloud
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        // set geopoint (passed verify)
        dispatch_group_t requestGroup = dispatch_group_create();
        dispatch_group_enter(requestGroup);
        [PFGeoPoint geoPointForCurrentLocationInBackground:^(PFGeoPoint *geoPoint, NSError *error) {
            if (!error) {
                self.geo = geoPoint;
                dispatch_group_leave(requestGroup);
            } else {
                completionHandler(NO, error);
            }
        }];
        
        // do otherthing waiting geopoints ready
        // set username information from current user (passed verify)
        PFUser *currentUser = [PFUser currentUser];
        self.username = [currentUser username];
        
        // set date
        NSDate *currentDate = [NSDate date];
        self.date = currentDate;
        
        // wait for geo point query complete
        dispatch_group_wait(requestGroup, DISPATCH_TIME_FOREVER);
        
        // save to cloud
        PFObject *object = [PFObject objectWithClassName:USERVIDEO_DB];
        [self _makeObject:object];
        [object saveInBackgroundWithBlock:completionHandler];
    });
    
    
    
}

-(void) retrieveCommentsInBackGround: (void(^)(NSError *error)) completionHandler {
    if (!self.id_) {
        //an error and return
        NSMutableDictionary *details = [NSMutableDictionary dictionary];
        [details setValue:@"The Id of video is not obtained" forKey:NSLocalizedDescriptionKey];
        NSError *error =[NSError errorWithDomain:@"Video" code:100 userInfo:details];
        completionHandler(error);
        return;
    }
    
    PFQuery *query = [PFQuery queryWithClassName:COMMENT_DB];
    [query whereKey:@"belongsTo" equalTo:self.id_];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (!error) {
            // print out for debug
            for (PFObject *object in objects) {
                [self.comments addObject: [[Comment alloc] initFromPFObject:object]];
                NSLog(@"%@", object[@"content"]);
            }
            completionHandler(error);
        } else {
            completionHandler(error);
        }
    }];
}


+(PFFile *) videoFileWithContentsOfURL:(NSURL *)url {
    // cache the first frame first
    NSData *videoData = [NSData dataWithContentsOfURL:url];
    return [PFFile fileWithName:@"video.mp4" data:videoData];
}

+(PFFile *) thumbnailFirstFrameOfURL:(NSURL *)url {
    MPMoviePlayerController *mp = [[MPMoviePlayerController alloc] initWithContentURL:url];
    mp.shouldAutoplay = NO;
    UIImage *img = [mp thumbnailImageAtTime:0 timeOption:MPMovieTimeOptionNearestKeyFrame];
    NSData *imageData = UIImagePNGRepresentation(img);
    return [PFFile fileWithName:@"img.png" data:imageData];
}

-(void) _makeObject: (PFObject *) object {
    object[@"username"] = self.username;
    object[@"date"] = self.date;
    object[@"location_id"] = self.location_id;
    object[@"geo"] = self.geo;
    object[@"video"] = self.video;
    object[@"thumbnail"] = self.thumbnail;
}

-(void) _parsePFObject: (PFObject *) object {
    self.id_ = object.objectId;
    self.username = object[@"username"];
    self.date = object[@"date"];
    self.location_id = object[@"location_id"];
    self.geo = object[@"geo"];
    self.video = object[@"video"];
    self.thumbnail = object[@"thumbnail"];
}

@end

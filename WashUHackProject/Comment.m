//
//  Comment.m
//  WashUHack
//
//  Created by Vincewang on 9/19/15.
//
//

#import "Comment.h"

@interface Comment ()
@property (nonatomic, strong) NSString *id_;
@end

@implementation Comment

@synthesize username;
@synthesize content;
@synthesize videoID;

#pragma mark -
#pragma mark override init to set username to current user
-(id)init {
    self = [super init];
    if (self) {
        self.username = [[PFUser currentUser] username];
    }
    return self;
}

-(id)initFromPFObject:(PFObject *)object {
    self = [super init];
    if (self) {
        [self _parsePFObject:object];
    }
    return self;
}

#pragma mark save the object to cloud

-(void) saveInBackGroundWithBlock:(void (^)(BOOL succeeded, NSError *error))completionHandler {
    if (!self.videoID) {
        //error check, generate an error and return
        NSMutableDictionary *details = [NSMutableDictionary dictionary];
        [details setValue:@"Associated Video Id is required!" forKey:NSLocalizedDescriptionKey];
        NSError *error =[NSError errorWithDomain:@"Comment" code:300 userInfo:details];
        completionHandler(NO, error);
        return;
    }
    
    PFObject *object = [self _makeObject];
    [object saveInBackgroundWithBlock:completionHandler];
}

-(PFObject *) _makeObject {
    PFObject *object = [[PFObject alloc]initWithClassName:Comment_DB];
    if (self.id_) { // modify
        object[@"id"] = self.id_;
    } else { // one to many mapping
        [object setObject:self.videoID forKey:@"belongsTo"];
    }
    object[@"username"] = self.username;
    object[@"content"] = self.content;
    
    return object;
}

-(void) _parsePFObject:(PFObject *)object {
    self.id_ = object[@"id"];
    self.username = object[@"username"];
    self.content = object[@"content"];
    self.videoID = object[@"belongsTo"];
}

@end

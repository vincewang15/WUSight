//
//  Comment.h
//  WashUHack
//
//  Created by Vincewang on 9/19/15.
//
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface Comment : NSObject

#define Comment_DB @"Comment"

@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *videoID;
@property (nonatomic, strong) NSString *content;

-(id)initFromPFObject:(PFObject *)object;

-(void) saveInBackGroundWithBlock:(void (^)(BOOL succeeded, NSError *error))completionHandler;
@end

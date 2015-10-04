//
//  UtilsTripAdvisor.h
//  WashUHack
//
//  Created by Vincewang on 9/19/15.
//
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import "Location.h"

@interface UtilsTripAdvisor : NSObject
+(void) searchLocationsByTerm:(NSString *)term withCategory:(NSString *)cate
            completionHandler: (void (^)(NSArray *longitude, NSError *error))completionHandler;
+(void) searchNearLocationByGeoPoint:(PFGeoPoint *)geo andCategory:(NSString *)cat
                   completionHandler: (void(^)(Location* loc, NSError *error)) completionHandler;
@end

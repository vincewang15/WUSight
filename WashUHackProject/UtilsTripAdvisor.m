//
//  UtilsTripAdvisor.m
//  WashUHack
//
//  Created by Vincewang on 9/19/15.
//
//

#import "UtilsTripAdvisor.h"


@implementation UtilsTripAdvisor

+(void) searchLocationsByTerm:(NSString *)term withCategory:(NSString *)cate
            completionHandler: (void (^)(NSArray *locations, NSError *error))completionHandler {
    [PFCloud callFunctionInBackground:@"searchForLocationByTerm" withParameters:@{@"term" :term} block:^(id  _Nullable response, NSError * _Nullable error) {
        if (!error) {
            NSMutableArray *array = [[NSMutableArray alloc] init];
            NSDictionary *locations = [NSJSONSerialization JSONObjectWithData:[response dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
            for (NSDictionary *loc in locations[cate]) {
                Location *locObj = [[Location alloc] initWithJSONData:loc andCategory:cate];
                [array addObject:locObj];
            }
            completionHandler(array, error);
        } else {
            completionHandler(nil, error);
        }
    }];
}

+(void) searchNearLocationByGeoPoint:(PFGeoPoint *)geo andCategory:(NSString *)cat
                   completionHandler: (void(^)(Location* loc, NSError *error)) completionHandler{
    [PFCloud callFunctionInBackground:@"searchNearLocationByGeoPoint" withParameters:@{@"geo" : geo, @"category" : cat} block:^(id  _Nullable response, NSError * _Nullable error) {
        if (!error) {
            NSDictionary *locations = [NSJSONSerialization JSONObjectWithData:[response dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
            // not really the nearest.
            completionHandler([[Location alloc] initWithJSONData:locations[@"data"][0] andCategory:cat], error);
        } else {
            completionHandler(nil, error);
        }
        
    }];
}

@end

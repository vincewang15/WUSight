//
//  Location.m
//  WashUHack
//
//  Created by Vincewang on 9/19/15.
//
//

#import "Location.h"

@implementation Location
@synthesize category;
@synthesize name;
@synthesize id_;
@synthesize geo;
@synthesize address_string;

-(id)initWithJSONData: (NSDictionary *) data andCategory:(NSString *) cate {
    self = [super init];
    if (self) {
        self.category = cate;
        self.name = data[@"name"];
        self.id_ = data[@"location_id"];
        self.geo = [PFGeoPoint geoPointWithLatitude:[data[@"latitude"] floatValue] longitude:[data[@"longitude"] floatValue]];
        self.address_string = data[@"address_obj"][@"address_string"];
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat: @"{cate:%@, name:%@, id_:%@, geo:%@, address:%@", self.category, self.name, self.id_, self.geo, self.address_string];
}
@end
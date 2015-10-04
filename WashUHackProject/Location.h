//
//  Location.h
//  WashUHack
//
//  Created by Vincewang on 9/19/15.
//
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface Location : UIViewController
@property (nonatomic, strong) NSString *category;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *id_;
@property (nonatomic, strong) PFGeoPoint *geo;
@property (nonatomic, strong) NSString *address_string;

-(id)initWithJSONData: (NSDictionary *) data andCategory:(NSString *) cate;
@end

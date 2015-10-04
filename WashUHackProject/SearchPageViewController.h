//
//  SearchPageViewController.h
//  WashUHack
//
//  Created by Vincewang on 9/19/15.
//
//

#import <UIKit/UIKit.h>
#import "UtilsTripAdvisor.h"
#import "Location.h"
#import "SearchResultsViewController.h"

@interface SearchPageViewController : UIViewController<UISearchBarDelegate>

@property(strong,nonatomic) NSString *choice;

@end

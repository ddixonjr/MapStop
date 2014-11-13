//
//  StopDetailTableViewController.h
//  MapStop
//
//  Created by Dennis Dixon on 5/29/14.
//  Copyright (c) 2014 Appivot LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "MSTPStopsService.h"

/**
 *  A view controller that facilitates the population of a view hierarchy displaying detailed transit authority stop information based on a populated Stop object passed in using the selectedStop property.
 */
@interface MSTPStopDetailTableViewController : UITableViewController

/**
 *  The stop object containing the detailed information to be displayed.
 */
@property (strong, nonatomic) MSTPStop *selectedStop;

@end

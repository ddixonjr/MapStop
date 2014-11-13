//
//  MapStopMainViewController.h
//  MapStop
//
//  Created by Dennis Dixon on 5/28/14.
//  Copyright (c) 2014 Appivot LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  A view controller that facilitates the population of a map view with transit authority stop information.  It creates the MKPointAnnotations by querying a StopsService object. This object gathers stop information and provides an API that facilitates access to the individual Stop model objects.
 */
@interface MapStopMainViewController : UIViewController

@end

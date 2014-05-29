//
//  StopDetailTableViewController.h
//  MapStop
//
//  Created by Dennis Dixon on 5/29/14.
//  Copyright (c) 2014 Appivot LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>


@interface StopDetailTableViewController : UITableViewController

@property (strong, nonatomic) NSString *stopName;
@property (strong, nonatomic) NSString *stopID;
@property (strong, nonatomic) NSString *stopAddress;
@property (strong, nonatomic) NSString *stopRoutes;
@property (strong, nonatomic) NSString *stopIntermodalTransfers;
@property (strong, nonatomic) MKPointAnnotation *stopPointAnnotation;

@end

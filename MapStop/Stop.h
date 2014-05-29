//
//  Stop.h
//  MapStop
//
//  Created by Dennis Dixon on 5/28/14.
//  Copyright (c) 2014 Appivot LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface Stop : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *stopID;
@property (strong, nonatomic) NSString *urlString;
@property (strong, nonatomic) NSString *routes;
@property (strong, nonatomic) NSString *direction;
@property (strong, nonatomic) NSString *intermodalTransfers;
@property (assign, readonly, nonatomic) CLLocationCoordinate2D coordinate;
@property (strong, nonatomic) UIImage *image;

- (id)initWithLatitude:(CLLocationDegrees)latitude andLongitude:(CLLocationDegrees)longitude;

@end

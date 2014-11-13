//
//  Stop.h
//  MapStop
//
//  Created by Dennis Dixon on 5/28/14.
//  Copyright (c) 2014 Appivot LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MSTPStop : NSObject

/**
 *  The name of the transit stop.
 */
@property (strong, nonatomic) NSString *name;


/**
 *  The transit authority designated identification number of the stop.
 */
@property (strong, nonatomic) NSString *stopID;


/**
 *  An NSString storing the transit authority URL for information regarding the stop.
 */
@property (strong, nonatomic) NSString *urlString;


/**
 *  The transit authority route numbers that service the stop.
 */
@property (strong, nonatomic) NSString *routes;


/**
 *  The direction of the routes at the stop.
 */
@property (strong, nonatomic) NSString *direction;


/**
 *  The other modes of transportation available for transfer at this stop.
 */
@property (strong, nonatomic) NSString *intermodalTransfers;


/**
 *  The geographical coordinate of this stop.
 */
@property (assign, readonly, nonatomic) CLLocationCoordinate2D coordinate;

/**
 *  The designated initializer that facilitates instantiation with geolocation information at a minimum.
 *
 *  @param latitude  latitude of the stop.
 *  @param longitude longitude of the stop.
 *
 *  @return A stop object with the geographical coordinate property set.
 */
- (id)initWithLatitude:(CLLocationDegrees)latitude andLongitude:(CLLocationDegrees)longitude;


/**
 *  Invokes reverse geolocation in the background to return an NSString holding the address via the completion handler.
 *
 *  @param completion a completion block that provides the resulting address or an NSError object if unable to complete the reverse geolocation.
 */
- (void)fetchAddressWithCompletionHandler:(void (^)(NSString *address, NSError *error))completion;

@end

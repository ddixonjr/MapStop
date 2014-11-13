//
//  StopsMap.h
//  MapStop
//
//  Created by Dennis Dixon on 5/28/14.
//  Copyright (c) 2014 Appivot LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "MSTPStop.h"

@class MSTPStopsService;

@protocol StopsServiceDelegate

- (void)stopsService:(MSTPStopsService *)stopsService didPullStopsWithError:(NSError *)error;

@end

@interface MSTPStopsService : NSObject

/**
 *  The delegate object to receive callbacks defined in the StopsServiceDelegate protocol
 */
@property (weak, nonatomic) id<StopsServiceDelegate> delegate;


/**
 *  Starts an asynchronous pull of transit stop information.  Upon completion the -stopsService:didPullStopsWithError: delegate method will be called
 *
 *  @param stopSetURLString An NSString specifying the URL. If nil, a default URL will be used.
 */
- (void)startPullOfStopSet:(NSString *)stopSetURLString;


/**
 *   Determines and returns the number of stops currently loaded in the StopsMap object.
 *
 *  @return the number of stops currently loaded in the StopsMap object.
 */
- (NSInteger)numberOfStopsInMap;


/**
 *  Returns the Stop object at the specified index
 *
 *  @param stopIndex index of the Stop object being requested.
 *
 *  @return the Stop object corresponding to the specified index.
 */
- (MSTPStop *)stopForStopAtIndex:(NSInteger)stopIndex;



@end

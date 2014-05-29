//
//  StopsMap.h
//  MapStop
//
//  Created by Dennis Dixon on 5/28/14.
//  Copyright (c) 2014 Appivot LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface StopsMap : NSObject

- (id)initWithDefaultStopSet;

- (NSInteger)numberOfStopsInMap;
- (NSString *)nameForStopAtIndex:(NSInteger)stopIndex;
- (NSString *)idForStopAtIndex:(NSInteger)stopIndex;
- (NSString *)directionForStopAtIndex:(NSInteger)stopIndex;
- (NSString *)routesForStopAtIndex:(NSInteger)stopIndex;
- (NSString *)urlStringForStopAtIndex:(NSInteger)stopIndex;
- (CLLocationCoordinate2D)coordinateForStopAtIndex:(NSInteger)stopIndex;
- (UIImage *)imageForStopAtIndex:(NSInteger)stopIndex;

@end

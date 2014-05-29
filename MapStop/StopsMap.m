//
//  StopsMap.m
//  MapStop
//
//  Created by Dennis Dixon on 5/28/14.
//  Copyright (c) 2014 Appivot LLC. All rights reserved.
//

#import "StopsMap.h"
#import "Stop.h"
#import <AddressBookUI/AddressBookUI.h>

#define kDefaultStopSetURLString @"https://s3.amazonaws.com/mobile-makers-lib/bus.json"

@interface StopsMap ()

@property (strong, nonatomic) NSMutableArray *stopSetArray;

@end


@implementation StopsMap

#pragma mark - Public Methods (StopsMap API)
- (id)init
{
    return [self initWithDefaultStopSet];
}


- (id)initWithDefaultStopSet
{
    self = [super init];
    if (self)
    {
        [self pullStopSet:kDefaultStopSetURLString];
    }
    return self;
}

- (NSInteger)numberOfStopsInMap;
{
    return self.stopSetArray.count;
}

- (NSString *)nameForStopAtIndex:(NSInteger)stopIndex
{
    Stop *stopAtIndex = [self.stopSetArray objectAtIndex:stopIndex];
    return stopAtIndex.name;
}


- (NSString *)addressForStopAtIndex:(NSInteger)stopIndex
{
    Stop *stopAtIndex = [self.stopSetArray objectAtIndex:stopIndex];
    CLLocation *stopLocation = [[CLLocation alloc] initWithCoordinate:stopAtIndex.coordinate
                                                             altitude:0.0
                                                   horizontalAccuracy:50.0
                                                     verticalAccuracy:50.0
                                                            timestamp:nil];
    __block NSString *addressString = @"Address not found";
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:stopLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        NSDictionary *firstAddressDictionary = [placemarks objectAtIndex:0];
        addressString =  ABCreateStringWithAddressDictionary(firstAddressDictionary, NO);
    }];

    NSLog(@"address string reverse geocoded is %@", addressString);
    return addressString;
}


- (NSString *)idForStopAtIndex:(NSInteger)stopIndex
{
    Stop *stopAtIndex = [self.stopSetArray objectAtIndex:stopIndex];
    return stopAtIndex.stopID;
}


- (NSString *)directionForStopAtIndex:(NSInteger)stopIndex;
{
    Stop *stopAtIndex = [self.stopSetArray objectAtIndex:stopIndex];
    return stopAtIndex.direction;
}


- (NSString *)routesForStopAtIndex:(NSInteger)stopIndex;
{
    Stop *stopAtIndex = [self.stopSetArray objectAtIndex:stopIndex];
    return stopAtIndex.routes;
}


- (NSString *)urlStringForStopAtIndex:(NSInteger)stopIndex;
{
    Stop *stopAtIndex = [self.stopSetArray objectAtIndex:stopIndex];
    return stopAtIndex.urlString;
}


- (NSString *)intermodalsForStopAtIndex:(NSInteger)stopIndex;
{
    Stop *stopAtIndex = [self.stopSetArray objectAtIndex:stopIndex];
    return (stopAtIndex.intermodalTransfers != nil) ? stopAtIndex.intermodalTransfers : @"None";
}


- (CLLocationCoordinate2D)coordinateForStopAtIndex:(NSInteger)stopIndex;
{
    Stop *stopAtIndex = [self.stopSetArray objectAtIndex:stopIndex];
    return stopAtIndex.coordinate;
}


- (UIImage *)imageForStopAtIndex:(NSInteger)stopIndex;
{
    Stop *stopAtIndex = [self.stopSetArray objectAtIndex:stopIndex];
    return stopAtIndex.image;
}

#pragma mark - Private Methods

- (void)pullStopSet:(NSString *)stopSetURLString
{
    NSURL *stopSetURL = [NSURL URLWithString:stopSetURLString];
    NSData *stopSetData = [NSData dataWithContentsOfURL:stopSetURL];

    NSError *error = [[NSError alloc] init];

    if (stopSetData)
    {
        //  Deliberately not setting properties so I can extract the data I need into the stop objects and drop the rest
        NSDictionary *stopSetDictionary = [NSJSONSerialization JSONObjectWithData:stopSetData options:NSJSONReadingAllowFragments  error:&error];
        NSArray *rawStopSetArray = [stopSetDictionary objectForKey:@"row"];
        [self buildStopSetModelFromRawStopSetArray:rawStopSetArray];
        NSLog(@"stopSetArray has the following %@",self.stopSetArray);
    }
}


- (void)buildStopSetModelFromRawStopSetArray:(NSArray *)rawStopSetArray
{
    for (NSDictionary *curStopDictionary in rawStopSetArray)
    {
        Stop *curStop = [[Stop alloc] initWithLatitude:[[curStopDictionary objectForKey:@"latitude"] doubleValue]
                                          andLongitude:[[curStopDictionary objectForKey:@"longitude"] doubleValue]];
        // load everything static but derive address from the latitude and longitude in the API method only when called
        curStop.name = [curStopDictionary objectForKey:@"cta_stop_name"];
        curStop.stopID = [curStopDictionary objectForKey:@"stop_id"];
        curStop.direction = [curStopDictionary objectForKey:@"direction"];
        curStop.routes = [curStopDictionary objectForKey:@"routes"];
        curStop.urlString = [curStopDictionary objectForKey:@"_address"];
        [self.stopSetArray addObject:curStop];
    }
}

- (NSMutableArray *)stopSetArray
{
    if (_stopSetArray == nil)
    {
        _stopSetArray = [[NSMutableArray alloc] init];
    }
    return _stopSetArray;
}

@end

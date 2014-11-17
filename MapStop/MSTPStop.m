//
//  Stop.m
//  MapStop
//
//  Created by Dennis Dixon on 5/28/14.
//  Copyright (c) 2014 Appivot LLC. All rights reserved.
//

#import "MSTPStop.h"
#import <AddressBookUI/AddressBookUI.h>


@interface MSTPStop ()

@property (assign, nonatomic) CLLocationCoordinate2D coordinate;

@end


@implementation MSTPStop


- (id)init
{
    return [self initWithLatitude:0.0 andLongitude:0.0];
}


- (id)initWithLatitude:(CLLocationDegrees)latitude andLongitude:(CLLocationDegrees)longitude
{
    self = [super init];
    if (self)
    {
        self.coordinate = CLLocationCoordinate2DMake(latitude,longitude);
    }
    return self;
}


- (NSString *)intermodalTransfers
{
    return (_intermodalTransfers) ? _intermodalTransfers : @"No Intermodal Transfers";
}

- (void)fetchAddressWithCompletionHandler:(void (^)(NSString *address, NSError *error))completion
{
    dispatch_queue_t backgroundQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    dispatch_async(backgroundQueue,^{
        CLGeocoder *geocoder = [[CLGeocoder alloc] init];
        CLLocation *stopLocation = [[CLLocation alloc] initWithLatitude:self.coordinate.latitude longitude:self.coordinate.longitude];
        [geocoder reverseGeocodeLocation:stopLocation completionHandler:^(NSArray *placemarks, NSError *error) {
            if (!error && placemarks.count)
            {
                CLPlacemark *firstPlacemark = [placemarks firstObject];
                NSString *address = ABCreateStringWithAddressDictionary(firstPlacemark.addressDictionary, NO);
                dispatch_async(dispatch_get_main_queue(),^{
                    completion(address,nil);
                });
            }
            else
            {
                completion(nil,error);
            }
        }];
    });
}


@end

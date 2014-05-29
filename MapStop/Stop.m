//
//  Stop.m
//  MapStop
//
//  Created by Dennis Dixon on 5/28/14.
//  Copyright (c) 2014 Appivot LLC. All rights reserved.
//

#import "Stop.h"

@interface Stop ()

@property (assign, nonatomic) CLLocationCoordinate2D coordinate;

@end


@implementation Stop


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



@end

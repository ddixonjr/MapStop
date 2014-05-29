//
//  ViewController.m
//  MapStop
//
//  Created by Dennis Dixon on 5/28/14.
//  Copyright (c) 2014 Appivot LLC. All rights reserved.
//

#import "MapStopMainViewController.h"
#import "StopsMap.h"

#define kDefaultCity @"Chicago, IL"
#define kStopPinAnnotationReuseID @"StopPinAnnotationView"

@interface MapStopMainViewController () <MKMapViewDelegate>

@property (strong, nonatomic) StopsMap *stopsMap;
@property (weak, nonatomic) IBOutlet MKMapView *stopsMapView;
@property (strong, nonatomic) NSMutableArray *stopAnnotationsArray;

@end



@implementation MapStopMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initializeStopMapView];
    [self buildStopAnnotationArrayAndStopMap];
}


- (void)initializeStopMapView
{
    self.stopsMapView.delegate = self;
    self.stopsMap = [[StopsMap alloc] initWithDefaultStopSet];
    self.stopAnnotationsArray = [[NSMutableArray alloc] init];

    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:kDefaultCity completionHandler:^(NSArray *placemarks, NSError *error)
    {
        CLPlacemark *firstPlacemark = [placemarks objectAtIndex:0];
        MKCoordinateSpan span = MKCoordinateSpanMake(0.4,0.4);
        MKCoordinateRegion region = MKCoordinateRegionMake(firstPlacemark.location.coordinate,span);
        [self.stopsMapView setRegion:region];
    }];
}

- (void)buildStopAnnotationArrayAndStopMap
{
    NSInteger numberOfStops = [self.stopsMap numberOfStopsInMap];
    for (NSInteger curStopIndex=0; curStopIndex<numberOfStops; curStopIndex++)
    {
        MKPointAnnotation *curStopPointAnnotation = [[MKPointAnnotation alloc] init];
        curStopPointAnnotation.title = [self.stopsMap nameForStopAtIndex:curStopIndex];
        curStopPointAnnotation.coordinate = [self.stopsMap coordinateForStopAtIndex:curStopIndex];
        curStopPointAnnotation.subtitle = [self.stopsMap routesForStopAtIndex:curStopIndex];
        [self.stopAnnotationsArray addObject:curStopPointAnnotation];
        [self.stopsMapView addAnnotation:curStopPointAnnotation];
    }
}


-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    MKPinAnnotationView *pin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:kStopPinAnnotationReuseID];
    pin.canShowCallout = YES;
    pin.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    pin.tag = [self.stopAnnotationsArray indexOfObject:annotation];
    NSLog(@"pin tag %d",pin.tag);
    return pin;
}



-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    NSLog(@"selected view has tag %d", view.tag);
}


-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{

}


@end

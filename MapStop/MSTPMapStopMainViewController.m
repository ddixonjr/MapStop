//
//  MapStopMainViewController.m
//  MapStop
//
//  Created by Dennis Dixon on 5/28/14.
//  Copyright (c) 2014 Appivot LLC. All rights reserved.
//

#import "MSTPMapStopMainViewController.h"
#import "MSTPStopsService.h"
#import "MSTPStopDetailTableViewController.h"
#import <MapKit/MapKit.h>
#import "MSTPAppDelegate.h"

#define kDefaultCity @"Chicago, IL"
#define kDefaultCoordinateSpanLat 0.4
#define kDefaultCoordinateSpanLon 0.4
#define kStopPinAnnotationReuseID @"StopPinAnnotationView"
#define kDebugOn NO

#define kAlertViewIndexRetry 0
#define kAlertViewIndexTryLater 1


@interface MSTPMapStopMainViewController () <MKMapViewDelegate,StopsServiceDelegate,UIAlertViewDelegate>

@property (strong, nonatomic) MSTPStopsService *stopsService;
@property (weak, nonatomic) IBOutlet MKMapView *stopsMapView;
@property (strong, nonatomic) NSMutableArray *stopAnnotationsArray;

@end



@implementation MSTPMapStopMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupVC];
}


#pragma mark - MKMapViewDelegate Methods

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    MKPinAnnotationView *pin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:kStopPinAnnotationReuseID];
    pin.canShowCallout = YES;
    pin.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    pin.tag = [self.stopAnnotationsArray indexOfObject:annotation];
    if (kDebugOn) NSLog(@"pin tag %ld", (long)pin.tag);
    return pin;
}


- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    if (kDebugOn) NSLog(@"selected view has tag %ld", (long)view.tag);
    [mapView deselectAnnotation:[self.stopAnnotationsArray objectAtIndex:view.tag] animated:NO];
    [self performSegueWithIdentifier:@"StopDetailSegue" sender:view];
}


#pragma mark  - UIAlertViewDelegate Methods

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex)
    {
        case kAlertViewIndexRetry:
            [self.stopsService startPullOfStopSet:nil];
            break;
        case kAlertViewIndexTryLater:
            abort();  //  Find out a cleaner way to terminate
         default:
            ;
    }
}


#pragma mark  - StopsServiceDelegate Methods

- (void)stopsService:(MSTPStopsService *)stopsService didPullStopsWithError:(NSError *)error
{
    if (!error)
    {
        [self buildStopAnnotationArrayAndStopMap];
        [self zoomMapViewToRegion];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Unable to Retrieve Data" message:@"Please Retry now or try again later." delegate:self cancelButtonTitle:@"Retry" otherButtonTitles:@"Try Later", nil];
        [alert show];
    }
}


#pragma mark - Helper Methods

- (void)setupVC
{
    self.stopsMapView.delegate = self;
    self.stopsService = [[MSTPStopsService alloc] init];
    self.stopsService.delegate = self;
    [self.stopsService startPullOfStopSet:nil];
}


- (void)buildStopAnnotationArrayAndStopMap
{
    NSInteger numberOfStops = [self.stopsService numberOfStopsInMap];
    self.stopAnnotationsArray = [NSMutableArray array];
    
    for (NSInteger curStopIndex=0; curStopIndex<numberOfStops; curStopIndex++)
    {
        MKPointAnnotation *curStopPointAnnotation = [[MKPointAnnotation alloc] init];
        MSTPStop *curStop = [self.stopsService stopForStopAtIndex:curStopIndex];
        curStopPointAnnotation.title = curStop.name;
        curStopPointAnnotation.coordinate = curStop.coordinate;
        curStopPointAnnotation.subtitle = curStop.routes;
        [self.stopAnnotationsArray addObject:curStopPointAnnotation];
        [self.stopsMapView addAnnotation:curStopPointAnnotation];
    }
}


- (void)zoomMapViewToRegion
{
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:kDefaultCity completionHandler:^(NSArray *placemarks, NSError *error)
     {
         if (!error)
         {
             CLPlacemark *firstPlacemark = [placemarks firstObject];
             MKCoordinateSpan span = MKCoordinateSpanMake(kDefaultCoordinateSpanLat,kDefaultCoordinateSpanLon);
             MKCoordinateRegion region = MKCoordinateRegionMake(firstPlacemark.location.coordinate,span);
             [self.stopsMapView setRegion:region animated:YES];
         }
     }];
}


#pragma mark  - App Navigation Methods

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"StopDetailSegue"])
    {
        if ([sender isKindOfClass:[MKPinAnnotationView class]])
        {
            MKPinAnnotationView *stopPinAnnotationView = (MKPinAnnotationView *) sender;
            MSTPStopDetailTableViewController *stopDetailVC = segue.destinationViewController;
            stopDetailVC.selectedStop = [self.stopsService stopForStopAtIndex:stopPinAnnotationView.tag];
        }
    }
}

@end








//
//  StopDetailTableViewController.m
//  MapStop
//
//  Created by Dennis Dixon on 5/29/14.
//  Copyright (c) 2014 Appivot LLC. All rights reserved.
//

#import "MSTPStopDetailTableViewController.h"

#define kDebugOn NO
#define kDefaultCoordinateSpanLat 0.01
#define kDefaultCoordinateSpanLon 0.01
#define kErrorAddressNotFoundString @"Unable to determine address"

@interface MSTPStopDetailTableViewController () <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet UITableViewCell *stopNameCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *stopAddressCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *stopRoutesCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *stopDirectionCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *stopIntermodalCell;
@property (weak, nonatomic) IBOutlet MKMapView *stopMapView;

@end

@implementation MSTPStopDetailTableViewController

#pragma mark - View Life Cycle and Initializaton Methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = [NSString stringWithFormat:@"Stop %@",self.selectedStop.stopID];
    [self populateStopTableView];
    [self populateStopMapView];

}


- (void)populateStopTableView
{
    self.stopAddressCell.detailTextLabel.text = @"Determining Address...";
    self.stopNameCell.detailTextLabel.text = self.selectedStop.name;
    self.stopRoutesCell.detailTextLabel.text = self.selectedStop.routes;
    self.stopDirectionCell.detailTextLabel.text = self.selectedStop.direction;
    self.stopIntermodalCell.detailTextLabel.text = self.selectedStop.intermodalTransfers;
    [self.selectedStop fetchAddressWithCompletionHandler:^(NSString *address, NSError *error) {
        if (!error)
        {
            self.stopAddressCell.detailTextLabel.text = (address.length) ? address : kErrorAddressNotFoundString;
        }
        else
        {
            self.stopAddressCell.detailTextLabel.text = kErrorAddressNotFoundString;
        }
    }];
}


- (void)populateStopMapView
{
    MKPointAnnotation *stopPointAnnotation = [[MKPointAnnotation alloc] init];
    stopPointAnnotation.title = self.selectedStop.name;
    stopPointAnnotation.coordinate = self.selectedStop.coordinate;
    stopPointAnnotation.subtitle = self.selectedStop.routes;

    self.stopMapView.delegate = self;

    MKCoordinateSpan stopSpan = MKCoordinateSpanMake(kDefaultCoordinateSpanLat,kDefaultCoordinateSpanLon);
    MKCoordinateRegion stopRegion = MKCoordinateRegionMake(stopPointAnnotation.coordinate, stopSpan);
    [self.stopMapView addAnnotation:stopPointAnnotation];
    [self.stopMapView setRegion:stopRegion animated:YES];
}

#pragma mark - MKMapViewDelegate Methods

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    MKPinAnnotationView *pin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"DetailStopAnnotationID"];
    pin.canShowCallout = NO;

    return pin;
}



@end

//
//  StopDetailTableViewController.m
//  MapStop
//
//  Created by Dennis Dixon on 5/29/14.
//  Copyright (c) 2014 Appivot LLC. All rights reserved.
//

#import "StopDetailTableViewController.h"

#define kDebugOn NO

@interface StopDetailTableViewController ()

@property (weak, nonatomic) IBOutlet UITableViewCell *stopNameCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *stopAddressCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *stopRoutesCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *stopIntermodalCell;
@property (weak, nonatomic) IBOutlet MKMapView *stopMapView;

@end

@implementation StopDetailTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = [NSString stringWithFormat:@"Stop %@",self.stopID];
    [self populateStopTableView];
    [self populateStopMapView];

}

- (void)populateStopTableView
{
    self.stopNameCell.detailTextLabel.text = self.stopName;
    self.stopRoutesCell.detailTextLabel.text = self.stopRoutes;
    self.stopIntermodalCell.detailTextLabel.text = self.stopIntermodalTransfers;
    self.stopAddress = [self.stopsMap addressForStopAtIndex:self.curStopIndex];

}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    self.stopAddressCell.detailTextLabel.text = [change objectForKey:NSKeyValueChangeNewKey];
    if (kDebugOn) NSLog(@"address %@",self.stopAddressCell.detailTextLabel.text);
}

- (void)populateStopMapView
{
    MKCoordinateSpan stopSpan = MKCoordinateSpanMake(0.01,0.01);
    MKCoordinateRegion stopRegion = MKCoordinateRegionMake(self.stopPointAnnotation.coordinate, stopSpan);
    [self.stopMapView addAnnotation:self.stopPointAnnotation];
    [self.stopMapView setRegion:stopRegion animated:YES];
}

@end

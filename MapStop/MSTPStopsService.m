//
//  StopsService.m
//  MapStop
//
//  Created by Dennis Dixon on 5/28/14.
//  Copyright (c) 2014 Appivot LLC. All rights reserved.
//

#import "MSTPStopsService.h"
#import "MSTPStop.h"

#define kDefaultStopSetURLString @"https://s3.amazonaws.com/mobile-makers-lib/bus.json"
#define kDebugOn NO
#define kDefaultLocationAltitude 0.0
#define kDefaultLocationAccuracyHorizontal 50.0
#define kDefaultLocationAccuracyVertical 50.0

#define kJSONKeyStopName  @"cta_stop_name"
#define kJSONKeyStopId  @"stop_id"
#define kJSONKeyStopDirection  @"direction"
#define kJSONKeyStopRoutes  @"routes"
#define kJSONKeyStopURLString  @"_address"
#define kJSONKeyStopsArray @"row"


@interface MSTPStopsService () <NSURLSessionDelegate, NSURLSessionDataDelegate>

@property (strong, nonatomic) NSMutableArray *stopSetArray;

@end


@implementation MSTPStopsService

#pragma mark - Public Methods (StopsService API)

- (NSInteger)numberOfStopsInMap;
{
    return self.stopSetArray.count;
}


- (MSTPStop *)stopForStopAtIndex:(NSInteger)stopIndex
{
    return [self.stopSetArray objectAtIndex:stopIndex];
}


#pragma mark - NSURLSession/SessionDataTask Delegate Methods

-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    NSLog(@"didReceiveData (%ld bytes)...", (long)data.length);
}


#pragma mark - Private Methods

- (void)startPullOfStopSet:(NSString *)stopSetURLString
{
    NSString *finalStopSetURLString = (stopSetURLString ? stopSetURLString : kDefaultStopSetURLString);
    NSURL *stopSetURL = [NSURL URLWithString:finalStopSetURLString];
    NSURLSessionConfiguration *stopsPullSessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *stopsPullSession = [NSURLSession sessionWithConfiguration:stopsPullSessionConfiguration
                                                                   delegate:self
                                                              delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *stopsPullSessionDataTask = [stopsPullSession dataTaskWithURL:stopSetURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (!error && data)
        {
            NSError *error = nil;
            NSDictionary *stopsPullDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                                options:NSJSONReadingAllowFragments
                                                                                  error:&error];
            [self buildStopSetModelFromRawStopSetArray:stopsPullDictionary[kJSONKeyStopsArray]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.delegate stopsService:self didPullStopsWithError:nil];
            });
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.delegate stopsService:self didPullStopsWithError:error];
            });
        }
    }];

    [stopsPullSessionDataTask resume];
}


- (void)buildStopSetModelFromRawStopSetArray:(NSArray *)rawStopSetArray
{
    for (NSDictionary *curStopDictionary in rawStopSetArray)
    {
        MSTPStop *curStop = [[MSTPStop alloc] initWithLatitude:[[curStopDictionary objectForKey:@"latitude"] doubleValue]
                                          andLongitude:[[curStopDictionary objectForKey:@"longitude"] doubleValue]];
        // load everything static but derive address from the latitude and longitude in the API method only when called
        curStop.name = [curStopDictionary objectForKey:kJSONKeyStopName];
        curStop.stopID = [curStopDictionary objectForKey:kJSONKeyStopId];
        curStop.direction = [curStopDictionary objectForKey:kJSONKeyStopDirection];
        curStop.routes = [curStopDictionary objectForKey:kJSONKeyStopRoutes];
        curStop.urlString = [curStopDictionary objectForKey:kJSONKeyStopURLString];
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

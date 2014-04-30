//
//  VIViewController.m
//  World Traveler
//
//  Created by Vincent Inverso on 4/27/14.
//  Copyright (c) 2014 Vincent Inverso. All rights reserved.
//

#import "VIListViewController.h"
#import "VIFourSquareSessionManager.h"
#import "AFMMRecordResponseSerializer.h"
#import "AFMMRecordResponseSerializationMapper.h"
#import "Venue.h"
#import "Location.h"
#import "VIMapViewController.h"

static NSString *const kCLIENTID = @"AMGRLRSEXMTCXZABT24HO0NKZSSWRHEG110FF0NMLZCBZP2S";
static NSString *const kCLIENTSECRET = @"4CBJSJ4ICWAYFC54OS5QTQ5TXQ3ZFSXCWAKT2KP31FJUCXXK";

#define latOffset 0.01
#define lngOffset 0.01

// AMGRLRSEXMTCXZABT24HO0NKZSSWRHEG110FF0NMLZCBZP2S
// Client secret
// 4CBJSJ4ICWAYFC54OS5QTQ5TXQ3ZFSXCWAKT2KP31FJUCXXK

@interface VIListViewController () <CLLocationManagerDelegate>

@property (strong, nonatomic) NSArray * venues;
@property (strong, nonatomic) CLLocationManager * locationManager;

@end

@implementation VIListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    self.locationManager.distanceFilter = 10.0;
    
    
    VIFourSquareSessionManager * sessionManager = [VIFourSquareSessionManager sharedClient];
    
    NSManagedObjectContext * context = [NSManagedObjectContext MR_defaultContext];
    AFHTTPResponseSerializer * responseSerializer = [AFJSONResponseSerializer serializer];
    AFMMRecordResponseSerializationMapper * mapper = [[AFMMRecordResponseSerializationMapper alloc] init];
    [mapper registerEntityName:@"Venue" forEndpointPathComponent:@"venues/search?"];
    
    AFMMRecordResponseSerializer *serializer = [AFMMRecordResponseSerializer serializerWithManagedObjectContext:context responseObjectSerializer:responseSerializer entityMapper:mapper];
    
    sessionManager.responseSerializer = serializer;
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- IBActions

- (IBAction)refreshBarButtonItemPressed:(UIBarButtonItem *)sender
{

    [self.locationManager startUpdatingLocation];
    
}

#pragma mark -- CLLocationManagerDelegate

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    
    CLLocation * location = [locations lastObject];
    
    [self.locationManager stopUpdatingLocation];
    
    [[VIFourSquareSessionManager sharedClient] GET:    [NSString stringWithFormat:@"venues/search?ll=%f,%f", location.coordinate.latitude + latOffset, location.coordinate.longitude + lngOffset] parameters:@{@"client_id" : kCLIENTID, @"client_secret" : kCLIENTSECRET, @"v" : @"20140416" } success:^(NSURLSessionDataTask *task, id responseObject)
     {
         NSArray * venues = responseObject;
         self.venues = venues;
         [self.tableView reloadData];
     }
     
        failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         NSLog(@"error : %@", error);
     }];
    
}

#pragma mark -- Segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    NSIndexPath * indexPath = [self.tableView indexPathForSelectedRow];
    Venue * venue = self.venues[indexPath.row];
    VIMapViewController * mapVC = segue.destinationViewController;
    mapVC.venue = venue;
    
}



#pragma mark -- UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [self.venues count];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    Venue * venue = self.venues[indexPath.row];
    cell.textLabel.text = venue.name;
    cell.detailTextLabel.text = venue.location.address;
    
    return cell;
    
}

@end











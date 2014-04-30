//
//  VIDirectionsViewController.m
//  World Traveler
//
//  Created by Vincent Inverso on 4/29/14.
//  Copyright (c) 2014 Vincent Inverso. All rights reserved.
//

#import "VIDirectionsViewController.h"
#import "VIDirectionsListViewController.h"

@interface VIDirectionsViewController ()

@end

@implementation VIDirectionsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.directionsMap.delegate = self;
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    [self.locationManager startUpdatingLocation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)listDirectionsBarButtonItemPressed:(UIBarButtonItem *)sender
{
    
    [self performSegueWithIdentifier:@"directionsToListSegue" sender:nil];
    
}



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([segue.destinationViewController isKindOfClass:[VIDirectionsListViewController class]])
    {
        VIDirectionsListViewController * vc = segue.destinationViewController;
        vc.steps = self.steps;
    }
    
}



-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    
    CLLocation * location = [locations lastObject];
    [manager stopUpdatingLocation];
    
    self.directionsMap.showsUserLocation = YES;
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(location.coordinate, 3000, 3000);
    [self.directionsMap setRegion:[self.directionsMap regionThatFits:region] animated:YES];
    
    float latitude = [self.venue.location.lat floatValue];
    float longitude = [self.venue.location.lng floatValue];
    
    MKPlacemark * pm = [[MKPlacemark alloc]initWithCoordinate:CLLocationCoordinate2DMake(latitude, longitude) addressDictionary:nil];
    MKMapItem * item = [[MKMapItem alloc]initWithPlacemark:pm];
    
    [self getDirections:item];
    
}

-(void) getDirections:(MKMapItem *)destination
{
    
    MKDirectionsRequest * request = [[MKDirectionsRequest alloc] init];
    
    request.source = [MKMapItem mapItemForCurrentLocation];
    request.destination = destination;
    request.requestsAlternateRoutes = YES;
    
    MKDirections * directions = [[MKDirections alloc]initWithRequest:request];
    [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
        if (error)
        {
            //error handle
        }
        else
        {
            //do something
            [self showRoute:response];
        }
    }];
    
    
}



-(void)showRoute:(MKDirectionsResponse*) response
{
    
    self.steps = response.routes;
    
    for (MKRoute * route in self.steps) {
        
        [self.directionsMap addOverlay:route.polyline level:MKOverlayLevelAboveRoads];
    
    }
    
}



-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
{
    
    MKPolylineRenderer * r = [[MKPolylineRenderer alloc]initWithOverlay:overlay];
    r.strokeColor = [UIColor redColor];
    r.lineWidth = 3.0;
    
    return  r;

}





@end

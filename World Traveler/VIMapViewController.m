//
//  VIMapViewController.m
//  World Traveler
//
//  Created by Vincent Inverso on 4/27/14.
//  Copyright (c) 2014 Vincent Inverso. All rights reserved.
//

#import "VIMapViewController.h"
#import "Location.h"
#import "FSCategory.h"
#import "VIDirectionsViewController.h"

@interface VIMapViewController ()

@end

@implementation VIMapViewController

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
    
    self.nameLabel.text = self.venue.name;
    self.addressLabel.text = self.venue.location.address;
    
    float latitude = [self.venue.location.lat floatValue];
    float longitude = [self.venue.location.lng floatValue];
    
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude, longitude);
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 800, 800);
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
    
    MKPointAnnotation * point = [[MKPointAnnotation alloc] init];
    point.coordinate = coordinate;
    point.title = self.venue.name;
    point.subtitle = self.venue.categories.name;
    
    [self.mapView addAnnotation:point];
    
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

- (IBAction)showDirectionsBarButtonItemPressed:(UIBarButtonItem *)sender
{

    [self performSegueWithIdentifier:@"mapToDirectionsSegue" sender:nil];
    
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[VIDirectionsViewController class]])
    {
        VIDirectionsViewController * nextVC = segue.destinationViewController;
        nextVC.venue = self.venue;
    }
    
    
}




@end

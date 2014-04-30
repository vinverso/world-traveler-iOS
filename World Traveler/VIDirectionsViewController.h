//
//  VIDirectionsViewController.h
//  World Traveler
//
//  Created by Vincent Inverso on 4/29/14.
//  Copyright (c) 2014 Vincent Inverso. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Venue.h"
#import "Location.h"

@interface VIDirectionsViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate>


- (IBAction)listDirectionsBarButtonItemPressed:(UIBarButtonItem *)sender;

@property (strong, nonatomic) IBOutlet MKMapView *directionsMap;
@property (strong, nonatomic) Venue * venue;
@property (strong, nonatomic) CLLocationManager * locationManager;
@property (strong, nonatomic) NSArray * steps;


@end

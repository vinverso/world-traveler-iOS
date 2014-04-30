//
//  VIMapViewController.h
//  World Traveler
//
//  Created by Vincent Inverso on 4/27/14.
//  Copyright (c) 2014 Vincent Inverso. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Venue.h"

@interface VIMapViewController : UIViewController

@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) Venue * venue;

- (IBAction)showDirectionsBarButtonItemPressed:(UIBarButtonItem *)sender;

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *addressLabel;

@end

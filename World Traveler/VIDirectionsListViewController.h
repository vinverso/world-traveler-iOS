//
//  VIDirectionsListViewController.h
//  World Traveler
//
//  Created by Vincent Inverso on 4/29/14.
//  Copyright (c) 2014 Vincent Inverso. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VIDirectionsListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>



@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray * steps;


@end

//
//  Venue.h
//  World Traveler
//
//  Created by Vincent Inverso on 4/27/14.
//  Copyright (c) 2014 Vincent Inverso. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "VIRecord.h"

@class Contact, FSCategory, Location, Menu;

@interface Venue : VIRecord

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * id;
@property (nonatomic, retain) FSCategory *categories;
@property (nonatomic, retain) Contact *contact;
@property (nonatomic, retain) Location *location;
@property (nonatomic, retain) Menu *menu;

@end

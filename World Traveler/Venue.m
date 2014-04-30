//
//  Venue.m
//  World Traveler
//
//  Created by Vincent Inverso on 4/27/14.
//  Copyright (c) 2014 Vincent Inverso. All rights reserved.
//

#import "Venue.h"
#import "Contact.h"
#import "FSCategory.h"
#import "Location.h"
#import "Menu.h"


@implementation Venue

@dynamic name;
@dynamic id;
@dynamic categories;
@dynamic contact;
@dynamic location;
@dynamic menu;

+(NSString *)keyPathForResponseObject
{
    
    return @"response.venues";
    
}

@end

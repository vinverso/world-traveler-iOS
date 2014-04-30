//
//  VIFourSquareSessionManager.m
//  World Traveler
//
//  Created by Vincent Inverso on 4/27/14.
//  Copyright (c) 2014 Vincent Inverso. All rights reserved.
//

#import "VIFourSquareSessionManager.h"

static NSString *const VIFourSquareBaseURLString = @"https://api.foursquare.com/v2/";

@implementation VIFourSquareSessionManager

+(instancetype) sharedClient
{
    
    static VIFourSquareSessionManager * _sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[VIFourSquareSessionManager alloc] initWithBaseURL:[NSURL URLWithString:VIFourSquareBaseURLString]];
    });
    return _sharedClient;
}

@end

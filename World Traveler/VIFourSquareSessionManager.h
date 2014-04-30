//
//  VIFourSquareSessionManager.h
//  World Traveler
//
//  Created by Vincent Inverso on 4/27/14.
//  Copyright (c) 2014 Vincent Inverso. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface VIFourSquareSessionManager : AFHTTPSessionManager

+(instancetype)sharedClient;

@end

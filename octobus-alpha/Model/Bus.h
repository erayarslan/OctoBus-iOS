//
//  Bus.h
//  octobus-alpha
//
//  Created by Ömer Hakan Bilici on 14.02.2014.
//  Copyright (c) 2014 8CookIn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Coordinate.h"

@interface Bus : NSObject

@property(nonatomic, strong) NSString *busId;
@property(nonatomic, strong) Coordinate *busCoordinate;

@end

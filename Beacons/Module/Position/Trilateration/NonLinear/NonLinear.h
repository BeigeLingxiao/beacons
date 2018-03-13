//
//  NonLinear.h
//  Group5iBeacons
//
//  Created by Nemanja Joksovic on 6/11/14.
//  Copyright (c) 2014 John Tubert. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BeaconDto.h"
#import <GoogleMaps/GoogleMaps.h>

@interface NonLinear : NSObject

+ (GMSMapPoint)determine:(NSArray *)beacons;

@end

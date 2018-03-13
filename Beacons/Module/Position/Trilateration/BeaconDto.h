//
//  Beacon.h
//  iBeacon-Geo-Demo
//
//  Created by Nemanja Joksovic on 4/6/14.
//  Copyright (c) 2014 R/GA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

#import <UIKit/UIKit.h>

@interface BeaconDto : NSObject

@property(assign, nonatomic) double accuracy;
@property(assign, nonatomic) double x;
@property(assign, nonatomic) double y;

- (instancetype)initWithAccuracy:(double)accuracy
                               x:(double)x
                               y:(double)y;
@end

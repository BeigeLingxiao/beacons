//
//  Beacon.m
//  iBeacon-Geo-Demo
//
//  Created by Nemanja Joksovic on 4/6/14.
//  Copyright (c) 2014 R/GA. All rights reserved.
//

#import "BeaconDto.h"

@implementation BeaconDto

- (instancetype)initWithAccuracy:(double)accuracy
                               x:(double)x
                               y:(double)y; {
    if (self = [super init]) {
        _x = x;
        _y = y;
        _accuracy = accuracy;
    }
    return self;
}

@end

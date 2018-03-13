//
//  NonLinear.m
//  Group5iBeacons
//
//  Created by Nemanja Joksovic on 6/11/14.
//  Copyright (c) 2014 John Tubert. All rights reserved.
//

#import "NonLinear.h"
#include <iostream>
#include "LevenbergMarquardt.h"

@implementation NonLinear

+ (GMSMapPoint)determine:(NSArray *)beacons {
  
  int count = (int) [beacons count];
  
  Eigen::VectorXd x(2);
  x << 0, 0;
  
  Eigen::MatrixXd matrix([beacons count], 3);
  
  for (int i = 0; i < count; i++) {
    BeaconDto *beacon = beacons[i];
    
    Eigen::VectorXd t(3);
    //  !!! with very small value of x y on equator (like 0.0000001) we need to multiply x and y, and then divide
    //  do not delete commented lines. Probably, somewhere in trilateration sh*t they use float
    // t << beacon.x * 100000000,
    // beacon.y * 100000000,
    t << beacon.x,
    beacon.y,
    beacon.accuracy;
    
    matrix.row(i) = t;
  }
  
  distance_functor functor(matrix, count);
  Eigen::NumericalDiff<distance_functor> numDiff(functor);
  Eigen::LevenbergMarquardt<Eigen::NumericalDiff<distance_functor>, double> lm(numDiff);
  lm.parameters.maxfev = 2000;
  lm.parameters.xtol = 1.49012e-08;
  lm.parameters.ftol = 1.49012e-08;
  lm.parameters.gtol = 0;
  lm.parameters.epsfcn = 0;
  Eigen::LevenbergMarquardtSpace::Status ret = lm.minimize(x);
  GMSMapPoint point;
  point.x = x[0];
  point.y = x[1];
  //  point.x = x[0] / 100000000;
  //  point.y = x[1] / 100000000;
  return point;
}

@end

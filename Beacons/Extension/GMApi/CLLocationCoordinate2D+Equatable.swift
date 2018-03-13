//
//  CLLocationCoordinate+Equatable.swift
//  Beacons
//
//  Created by Антон Назаров on 16/12/2017.
//  Copyright © 2017 com.epam. All rights reserved.
//

extension CLLocationCoordinate2D: Equatable {
  public static func == (left: CLLocationCoordinate2D, right: CLLocationCoordinate2D) -> Bool {
    return fabs(left.latitude - right.latitude) < CoordinateConstant.delta &&
      fabs(left.longitude - right.longitude) < CoordinateConstant.delta
  }
}

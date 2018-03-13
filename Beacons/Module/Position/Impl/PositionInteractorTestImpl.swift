//
//  PositionInteractorTestImpl.swift
//  Beacons
//
//  Created by Антон Назаров on 17.10.2017.
//  Copyright © 2017 com.epam All rights reserved.
//

import GoogleMaps
import RxSwift
import RxCocoa

class PositionInteractorTestImpl: PositionInteractor {
  var position: Driver<CLLocationCoordinate2D>!
  var beacons: Driver<[GMSCircle]>!
  var locationManager = CLLocationManager()

  init() {
    position = Driver.just(CLLocationCoordinate2DMake(CameraConstant.startLatitude, CameraConstant.startLongitude))
    beacons = Driver.just([GMSCircle]())
  }
}

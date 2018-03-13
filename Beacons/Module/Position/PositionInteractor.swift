//
//  PositionInteractor.swift
//  Beacons
//
//  Created by Антон Назаров on 16/12/2017.
//  Copyright © 2017 com.epam All rights reserved.
//

import RxSwift
import RxCocoa

protocol PositionInteractor {
  var locationManager: CLLocationManager { get }
  var position: Driver<CLLocationCoordinate2D>! { get }
  var beacons: Driver<[GMSCircle]>! { get }
}

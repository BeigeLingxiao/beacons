//
//  PositionHandlingInteractorImpl.swift
//  Beacons
//
//  Created by Антон Назаров on 26.10.2017.
//  Copyright © 2017 com.epam All rights reserved.
//

import RxSwift

class PositionHandlingInteractorImpl: PositionHandlingInteractor {
  func handle(beacons: [BeaconDto]) -> CLLocationCoordinate2D {
    return GMSUnproject(NonLinear.determine(beacons))
  }
}

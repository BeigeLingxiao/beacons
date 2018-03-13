//
//  PositionHandlingInteractor.swift
//  Beacons
//
//  Created by Антон Назаров on 26.10.2017.
//  Copyright © 2017 com.epam All rights reserved.
//

// Use it to add additional logic to position calculation
protocol PositionHandlingInteractor {
  func handle(beacons: [BeaconDto]) -> CLLocationCoordinate2D
}

//
//  BeaconServiceTestImpl.swift
//  Beacons
//
//  Created by Антон Назаров on 26.10.2017.
//  Copyright © 2017 com.epam All rights reserved.
//

import ObjectMapper

class BeaconServiceTestImpl: BeaconService {
  private lazy var beacons = getBeacons()

  private func getBeacons() -> [Beacon] {
    return Mapper<Beacon>().mapArray(JSONString: Utils.getJSON(name: "MockedEstimoteBeacon")) ?? []
  }

  func getAll(fromBuilding: Int, floor: String) -> [Beacon] {
    return beacons
  }
}

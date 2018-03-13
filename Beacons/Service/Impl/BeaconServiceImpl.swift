//
//  BeaconServiceImpl.swift
//  Beacons
//
//  Created by Антон Назаров on 26.10.2017.
//  Copyright © 2017 com.epam All rights reserved.
//

class BeaconServiceImpl: BeaconService {
  private let beaconRepository: BeaconRepository

  init(beaconRepository: BeaconRepository) {
    self.beaconRepository = beaconRepository
  }

  func getAll(fromBuilding: Int, floor: String) -> [Beacon] {
    return beaconRepository.getAll(fromBuilding: fromBuilding, floor: floor)
  }
}

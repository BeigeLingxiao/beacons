//
//  BeaconService.swift
//  Beacons
//
//  Created by Антон Назаров on 26.10.2017.
//  Copyright © 2017 com.epam All rights reserved.
//

protocol BeaconService {
  func getAll(fromBuilding id: Int, floor: String) -> [Beacon]
}

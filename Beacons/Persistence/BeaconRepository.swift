//
//  BeaconRepository.swift
//  Beacons
//
//  Created by Антон Назаров on 07.11.2017.
//  Copyright © 2017 com.epam All rights reserved.
//

import RealmSwift

class BeaconRepository {
  private let realmManager: RealmManager

  init(realmManager: RealmManager) {
    self.realmManager = realmManager
  }

  func getAll(fromBuilding id: Int, floor number: String) -> [Beacon] {
    return realmManager.submit {
      $0.objects(Beacon.self).filter { $0.floor.building.id == id && $0.floor.number == number }
    }
  }
}

//
//  FloorRepository.swift
//  Beacons
//
//  Created by Антон Назаров on 05.10.2017.
//  Copyright © 2017 com.epam All rights reserved.
//

import RealmSwift

class FloorRepository {
  private let realmManager: RealmManager

  init(realmManager: RealmManager) {
    self.realmManager = realmManager
  }

  func replace(floors: [Floor], in building: Int) throws -> [Floor] {
    try realmManager.execute { realm in
      try realm.write {
        guard let buildingEntity = realm.object(ofType: Building.self, forPrimaryKey: building) else {
          fatalError("building not found \(building)")
        }
        realm.delete(buildingEntity.floors, cascading: true)
        buildingEntity.floors.append(objectsIn: floors)
      }
    }
    return floors
  }

  func get(number: String, from building: Int) -> Floor? {
    return realmManager.submit {
      $0.object(ofType: Building.self, forPrimaryKey: building)?.floors.first { $0.number == number }
    }
  }
}

//
//  BuildingsRepository.swift
//  Beacons
//
//  Created by Антон Назаров on 04.10.2017.
//  Copyright © 2017 com.epam All rights reserved.
//

import RealmSwift

class BuildingRepository {
  private let realmManager: RealmManager

  init(realmManager: RealmManager) {
    self.realmManager = realmManager
  }

  func replaceAll(_ buildings: [Building]) throws -> [Building] {
    try realmManager.execute { realm in
      try realm.write {
        realm.delete(realm.objects(Building.self), cascading: true)
        realm.add(buildings, update: true)
      }
    }
    return buildings
  }

  func getAll() -> Results<Building> {
    return realmManager.submit { $0.objects(Building.self) }
  }

  func get(by id: Int) -> Building? {
    return realmManager.submit { $0.object(ofType: Building.self, forPrimaryKey: id) }
  }
}

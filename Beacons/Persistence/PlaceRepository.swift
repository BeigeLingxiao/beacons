//
//  PlaceRepository.swift
//  Beacons
//
//  Created by Антон Назаров on 10.10.2017.
//  Copyright © 2017 com.epam All rights reserved.
//

import RealmSwift

class PlaceRepository {
  private let realmManager: RealmManager

  init(realmManager: RealmManager) {
    self.realmManager = realmManager
  }

  func search(query: String) -> Results<Place> {
    return realmManager.submit { $0.objects(Place.self).filter("descr CONTAINS[cd] %@", query) }
  }

  func get(by id: Int) -> Place? {
    return realmManager.submit { $0.object(ofType: Place.self, forPrimaryKey: id) }
  }

  func getAll(from id: Int) -> [Place] {
    return realmManager.submit { $0.objects(Place.self).filter { $0.floor.building.id == id } }
  }
}

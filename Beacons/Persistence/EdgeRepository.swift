//
//  EdgeRepository.swift
//  Beacons
//
//  Created by Антон Назаров on 07.11.2017.
//  Copyright © 2017 com.epam All rights reserved.
//

import RealmSwift

final class EdgeRepository {
  private let realmManager: RealmManager

  init(realmManager: RealmManager) {
    self.realmManager = realmManager
  }

  func getAll(from id: Int) -> [Edge] {
    return realmManager.submit { $0.objects(Edge.self).filter { $0.floor.building.id == id } }
  }
}

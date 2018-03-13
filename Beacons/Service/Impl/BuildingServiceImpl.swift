//
//  BuildingServiceImpl.swift
//  Beacons
//
//  Created by Антон Назаров on 17.10.2017.
//  Copyright © 2017 com.epam All rights reserved.
//

import RealmSwift
import RxRealm
import RxSwift

final class BuildingServiceImpl: BuildingService {
  private let buildingRepository: BuildingRepository

  init(buildingRepository: BuildingRepository) {
    self.buildingRepository = buildingRepository
  }

  func get(by id: Int) -> Observable<Building> {
    guard let building = buildingRepository.get(by: id) else {
      fatalError("id = \(id)")
    }
    return Observable.from(object: building, properties: ["floors"])
  }

  func replaceAll(_ buildings: [Building]) -> [Building] {
    do {
      let buildings = try buildingRepository.replaceAll(buildings)
      buildings.forEach { log.debug("id = \($0.id)") }
      return buildings
    } catch {
      fatalError("\(buildings.count)")
    }
  }

  func getAll() -> Observable<Results<Building>> {
    return Observable.collection(from: buildingRepository.getAll())
  }
}

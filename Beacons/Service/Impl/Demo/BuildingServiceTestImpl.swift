//
//  BuildingServiceTestImpl.swift
//  Beacons
//
//  Created by Антон Назаров on 25.09.17.
//  Copyright © 2017 com.epam All rights reserved.
//

import ObjectMapper
import RealmSwift
import RxSwift

class BuildingServiceTestImpl: BuildingService {
  private lazy var buildings = getBuildings()

  func get(by id: Int) -> Observable<Building> {
    for building in buildings where building.id == id {
      return Observable.just(building)
    }
    fatalError("Building not found id = \(id)")
  }

  func insert(building: Building) -> Building { fatalError("insert(building:) has not been implemented") }

  func replaceAll(_ buildings: [Building]) -> [Building] {
    self.buildings.append(contentsOf: buildings)
    return buildings
  }

  func getAll() -> Observable<Results<Building>> {
    let realm = try! Realm()
    try! realm.write {
       realm.add(buildings, update: true)
    }
    return Observable.collection(from: realm.objects(Building.self))
  }

  private func getBuildings() -> [Building] {
    return Mapper<Building>().mapArray(JSONString: Utils.getJSON(name: "MockedBuilding")) ?? []
  }
}

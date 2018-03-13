//
//  FloorServiceImpl.swift
//  Beacons
//
//  Created by Антон Назаров on 04.11.2017.
//  Copyright © 2017 com.epam All rights reserved.
//

class FloorServiceImpl: FloorService {
  private let floorRepository: FloorRepository

  init(floorRepository: FloorRepository) {
    self.floorRepository = floorRepository
  }

  func replace(floors: [Floor], inBuilding id: Int) -> [Floor] {
    do {
      let floors = try floorRepository.replace(floors: floors, in: id)
      log.debug("\(id) added \(floors.count) floors")
      return floors
    } catch {
      log.error("id = \(id)")
      return []
    }
  }

  func get(number: String, fromBuilding building: Int) -> Floor {
    guard let floor = floorRepository.get(number: number, from: building) else {
      fatalError("id = \(building), number = \(number)")
    }
    return floor
  }
}

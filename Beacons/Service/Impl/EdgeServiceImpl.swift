//
//  EdgeServiceImpl.swift
//  Beacons
//
//  Created by Антон Назаров on 07.11.2017.
//  Copyright © 2017 com.epam All rights reserved.
//

final class EdgeServiceImpl: EdgeService {
  private let edgeRepository: EdgeRepository

  init(edgeRepository: EdgeRepository) {
    self.edgeRepository = edgeRepository
  }

  func getAll(fromBuilding id: Int) -> [Edge] {
    return edgeRepository.getAll(from: id)
  }
}

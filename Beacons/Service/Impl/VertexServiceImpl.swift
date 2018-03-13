//
//  VertexServiceImpl.swift
//  Beacons
//
//  Created by Антон Назаров on 17.10.2017.
//  Copyright © 2017 com.epam All rights reserved.
//

import GoogleMaps

class VertexServiceImpl: VertexService {
  private let vertexRepository: VertexRepository

  init(vertexRepository: VertexRepository) {
    self.vertexRepository = vertexRepository
  }

  func getNearest(to point: CLLocationCoordinate2D) -> Vertex {
    guard let vertex = vertexRepository.getNearest(to: point) else {
      fatalError("No vertexes at all")
    }
    return vertex
  }

  func getAll(fromBuilding id: Int) -> [Vertex] {
    return vertexRepository.getAll(fromBuilding: id)
  }
}

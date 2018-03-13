//
//  EdgeServiceTestImpl.swift
//  Beacons
//
//  Created by Антон Назаров on 07.11.2017.
//  Copyright © 2017 com.epam All rights reserved.
//

import ObjectMapper

class EdgeServiceTestImpl: EdgeService {
  private lazy var edges = getEdges()

  func getAll(fromBuilding id: Int) -> [Edge] {
    return edges
  }

  private func getEdges() -> [Edge] {
    return Mapper<Edge>().mapArray(JSONString: Utils.getJSON(name: "MockedEdge")) ?? []
  }
}

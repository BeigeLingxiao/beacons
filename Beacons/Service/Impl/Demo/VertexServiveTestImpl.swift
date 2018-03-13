//
//  VertexServiveTestImpl.swift
//  Beacons
//
//  Created by Антон Назаров on 23.10.2017.
//  Copyright © 2017 com.epam All rights reserved.
//

import GoogleMaps
import ObjectMapper

final class VertexServiceTestImpl: VertexService {
  private lazy var vertexes = getVertexes()

  func getNearest(to point: CLLocationCoordinate2D) -> Vertex {
    return vertexes.min {
      compareByDistanceToPoint(lhs: $0, rhs: $1, point: point)
    }!
  }

  func add(array: [Vertex]) -> [Vertex] {
    array.forEach { vertexes.append($0) }
    return array
  }

  func getAll(fromBuilding id: Int) -> [Vertex] {
    return vertexes
  }

  private func compareByDistanceToPoint(lhs: Vertex, rhs: Vertex, point: CLLocationCoordinate2D) -> Bool {
    return distance(from: lhs, to: point) < distance(from: rhs, to: point)
  }

  private func distance(from vertex: Vertex, to point: CLLocationCoordinate2D) -> Double {
    return sqrt(pow(vertex.latitude - point.latitude, 2) + pow(vertex.longitude - point.longitude, 2))
  }

  private func getVertexes() -> [Vertex] {
    return Mapper<Vertex>().mapArray(JSONString: Utils.getJSON(name: "MockedVertex")) ?? []
  }
}

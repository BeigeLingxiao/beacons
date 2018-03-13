//
//  VertexRepository.swift
//  Beacons
//
//  Created by Антон Назаров on 09.10.2017.
//  Copyright © 2017 com.epam All rights reserved.
//

import RealmSwift
import GoogleMaps

class VertexRepository {
  private let realmManager: RealmManager

  init(realmManager: RealmManager) {
    self.realmManager = realmManager
  }

  func getNearest(to point: CLLocationCoordinate2D) -> Vertex? {
    return realmManager.submit {
      $0.objects(Vertex.self).min {
        compareByDistanceToPoint(lhs: $0, rhs: $1, point: point)
      }
    }
  }

  func getAll(fromBuilding id: Int) -> [Vertex] {
    return realmManager.submit { $0.objects(Vertex.self).filter { $0.floor.building.id == id } }
  }
  
  private func compareByDistanceToPoint(lhs: Vertex, rhs: Vertex, point: CLLocationCoordinate2D) -> Bool {
    return distance(from: lhs, to: point) < distance(from: rhs, to: point)
  }

  private func distance(from vertex: Vertex, to point: CLLocationCoordinate2D) -> Double {
    return sqrt(pow(vertex.latitude - point.latitude, 2) + pow(vertex.longitude - point.longitude, 2))
  }
}

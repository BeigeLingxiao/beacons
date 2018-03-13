//
//  VertexService.swift
//  Beacons
//
//  Created by Антон Назаров on 17.10.2017.
//  Copyright © 2017 com.epam All rights reserved.
//

protocol VertexService {
  func getNearest(to point: CLLocationCoordinate2D) -> Vertex

  func getAll(fromBuilding id: Int) -> [Vertex]
}

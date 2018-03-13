//
//  Edge.swift
//  Beacons
//
//  Created by Антон Назаров on 04.10.2017.
//  Copyright © 2017 com.epam All rights reserved.
//

import RealmSwift
import ObjectMapper

@objcMembers class Edge: Object {
  dynamic var weight: Float = 0.0
  dynamic var v1: Int = 0
  dynamic var v2: Int = 0

  private let floors = LinkingObjects(fromType: Floor.self, property: "edges")

  var floor: Floor {
    //swiftlint:disable:next force_unwrapping
    return self.floors.first!
  }

  required convenience init?(map: Map) {
    self.init()
  }
}

extension Edge: Mappable {
  func mapping(map: Map) {
    weight <- map["weight"]
    v1 <- map["v1"]
    v2 <- map["v2"]
  }
}

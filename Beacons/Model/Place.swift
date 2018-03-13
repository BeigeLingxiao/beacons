//
//  Place.swift
//  Beacons
//
//  Created by Антон Назаров on 04.10.2017.
//  Copyright © 2017 com.epam All rights reserved.
//

import RealmSwift
import ObjectMapper

@objcMembers class Place: Object {
  dynamic var id: Int = 0
  dynamic var type: String = ""
  dynamic var descr: String = ""
  /// Use pos property instead
  dynamic var latitude: Double = 0.0
  /// Use pos property instead
  dynamic var longitude: Double = 0.0

  var pos: CLLocationCoordinate2D {
    return CLLocationCoordinate2DMake(latitude, longitude)
  }

  private let floors = LinkingObjects(fromType: Floor.self, property: "places")

  var floor: Floor {
    //swiftlint:disable:next force_unwrapping
    return self.floors.first!
  }

  override class func primaryKey() -> String? {
    return #keyPath(Place.id)
  }

  required convenience init?(map: Map) {
    self.init()
  }
}

extension Place: Mappable {
  func mapping(map: Map) {
    id <- map["id"]
    latitude <- map["coordinate.latitude"]
    longitude <- map["coordinate.longitude"]
    type <- map["type"]
    descr <- map["description"]
  }
}

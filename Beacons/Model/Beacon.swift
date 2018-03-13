//
//  Beacon.swift
//  Beacons
//
//  Created by Антон Назаров on 04.10.2017.
//  Copyright © 2017 com.epam All rights reserved.
//

import RealmSwift
import ObjectMapper

@objcMembers class Beacon: Object {
  /// Use pos property instead
  dynamic var latitude: Double = 0.0
  /// Use pos property instead
  dynamic var longitude: Double = 0.0
  dynamic var major: Int16 = 0
  dynamic var minor: Int16 = 0
  /// Use uuid property instead
  dynamic var uuidString: String = ""

  private let floors = LinkingObjects(fromType: Floor.self, property: "beacons")

  var floor: Floor {
    //swiftlint:disable:next force_unwrapping
    return self.floors.first!
  }

  var pos: CLLocationCoordinate2D {
    return CLLocationCoordinate2DMake(latitude, longitude)
  }

  var uuid: UUID {
    //swiftlint:disable:next force_unwrapping
    return UUID(uuidString: uuidString)!
  }

  required convenience init?(map: Map) {
    self.init()
  }
}

extension Beacon: Mappable {
  func mapping(map: Map) {
    latitude <- map["coordinate.latitude"]
    longitude <- map["coordinate.longitude"]
    major <- map["major"]
    minor <- map["minor"]
    uuidString <- map["uuid"]
  }
}

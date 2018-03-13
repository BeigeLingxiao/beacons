//
//  Building.swift
//  Beacons
//
//  Created by Антон Назаров on 04.10.2017.
//  Copyright © 2017 com.epam All rights reserved.
//

import ObjectMapper
import GoogleMaps
import RealmSwift

@objcMembers class Building: Object {
  dynamic var descr: String = ""
  /// Use url property instead
  dynamic var urlString: String = ""
  dynamic var id: Int = 0
  /// Use pos property instead
  dynamic var latitude: Double = 0.0
  /// Use pos property instead
  dynamic var longitude: Double = 0.0
  dynamic var name: String = ""

  var floors = List<Floor>()

  var url: URL {
    guard let url = URL(string: urlString) else {
      fatalError("Not valid url for building \(id)")
    }
    return url
  }

  var pos: CLLocationCoordinate2D {
    return CLLocationCoordinate2DMake(latitude, longitude)
  }

  override class func primaryKey() -> String? {
    return #keyPath(Building.id)
  }

  required convenience init?(map: Map) {
    self.init()
  }
}

extension Building: Mappable {
  func mapping(map: Map) {
    id <- map["id"]
    latitude <- map["coordinate.latitude"]
    longitude <- map["coordinate.longitude"]
    name <- map["name"]
    urlString <- map["icon"]
    descr <- map["description"]
    #if MOCK
    floors <- map["floors"]
    #endif
  }
}

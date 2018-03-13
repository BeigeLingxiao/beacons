//
//  Floor.swift
//  Beacons
//
//  Created by Антон Назаров on 04.10.2017.
//  Copyright © 2017 com.epam All rights reserved.
//

import RealmSwift
import ObjectMapper

@objcMembers class Floor: Object {
  /// Use url property instead
  dynamic var urlString: String = ""
  dynamic var number: String = ""
  dynamic var width: Double = 0.0
  dynamic var height: Double = 0.0
  /// Use northEast property instead
  dynamic var overlayNorthEastLatitude: Double = 0.0
  /// Use northEast property instead
  dynamic var overlayNorthEastLongitude: Double = 0.0
  /// Use southWest property instead
  dynamic var overlaySouthWestLatitude: Double = 0.0
  /// Use southWest property instead
  dynamic var overlaySouthWestLongitude: Double = 0.0

  var beacons = List<Beacon>()
  var edges = List<Edge>()
  var places = List<Place>()
  var vertices = List<Vertex>()

  var url: URL {
    guard let url = URL(string: urlString) else {
      fatalError("Not valid url for floor \(number) of building \(building.id)")
    }
    return url
  }

  var northEast: CLLocationCoordinate2D {
    return CLLocationCoordinate2DMake(overlayNorthEastLatitude, overlayNorthEastLongitude)
  }

  var southWest: CLLocationCoordinate2D {
    return CLLocationCoordinate2DMake(overlaySouthWestLatitude, overlaySouthWestLongitude)
  }

  private let buildings = LinkingObjects(fromType: Building.self, property: "floors")
  var building: Building {
    //swiftlint:disable:next force_unwrapping
    return self.buildings.first!
  }

  required convenience init?(map: Map) {
    self.init()
  }
}

extension Floor: Mappable {
  func mapping(map: Map) {
    urlString <- map["image"]
    number <- map["number"]
    beacons <- map["beacons"]
    edges <- map["edges"]
    places <- map["places"]
    vertices <- map["vertices"]
    width <- map["width"]
    height <- map["height"]
    overlayNorthEastLatitude <- map["overlayNorthEastLatitude"]
    overlayNorthEastLongitude <- map["overlayNorthEastLongitude"]
    overlaySouthWestLatitude <- map["overlaySouthWestLatitude"]
    overlaySouthWestLongitude <- map["overlaySouthWestLongitude"]
  }
}

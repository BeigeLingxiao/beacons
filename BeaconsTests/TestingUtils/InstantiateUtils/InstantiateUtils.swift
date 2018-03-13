//
// Created by Антон Назаров on 06.10.2017.
// Copyright (c) 2017 com.epam All rights reserved.
//

import Foundation
import RealmSwift
import Fakery

enum InstantiateUtils {
  private static let faker = Faker(locale: "nb-NO")
  private static let MAX_LIST_COUNT = UInt32(20)

  static func toAny<T>(_ array: [T]) -> [Any] {
    var newArray = [Any]()
    for item in array {
      newArray.append(item)
    }
    return newArray
  }

  enum Collections {
    static func someList<T>(_ generator: () -> T) -> List<T> {
      return List<T>().then {
        let size = 1 + arc4random_uniform(MAX_LIST_COUNT)
        for _ in 0..<size {
          $0.append(generator())
        }
      }
    }

    static func someArray<T>(_ generator: () -> T) -> [T] {
      var array = [T]()
      let size = 1 + arc4random_uniform(MAX_LIST_COUNT)
      for _ in 0..<size {
        array.append(generator())
      }
      return array
    }

    static func someResults<T>(_ generator: () -> T) -> Results<T> {
      return someList(generator).filter("TRUEPREDICATE")
    }
  }

  enum Entity {
    static func someBuilding() -> Building {
      let building = someBuildingWithoutFloors()
      building.floors = Collections.someList(someFloor)
      return building
    }

    static func someBuildingWithoutFloors() -> Building {
      let building = Building()
      building.descr = Primitives.someString()
      building.urlString = Primitives.someImageUrl()
      building.latitude = Primitives.someLatitude()
      building.longitude = Primitives.someLongitude()
      building.id = Primitives.someId()
      building.name = faker.address.streetAddress()
      return building
    }

    static func someFloor() -> Floor {
      let floor = Floor()
      floor.number = Primitives.someString()
      floor.overlayNorthEastLatitude = Primitives.someLatitude()
      floor.overlayNorthEastLongitude = Primitives.someLongitude()
      floor.overlaySouthWestLatitude = Primitives.someLatitude()
      floor.overlaySouthWestLongitude = Primitives.someLongitude()
      floor.width = Primitives.someDouble()
      floor.height = Primitives.someDouble()
      floor.urlString = Primitives.someImageUrl()
      floor.beacons = Collections.someList(someBeacon)
      floor.places = Collections.someList(somePlace)
      floor.edges = Collections.someList(someEdge)
      floor.vertices = Collections.someList(someVertex)
      return floor
    }

    static func someBeacon() -> Beacon {
      let beacon = Beacon()
      beacon.latitude = Primitives.someLatitude()
      beacon.longitude = Primitives.someLongitude()
      beacon.major = Int16(Primitives.someInt())
      beacon.minor = Int16(Primitives.someInt())
      beacon.uuidString = Primitives.someString()
      return beacon
    }

    static func someVertex() -> Vertex {
      let vertex = Vertex()
      vertex.id = Primitives.someId()
      vertex.latitude = Primitives.someLatitude()
      vertex.longitude = Primitives.someLongitude()
      return vertex
    }

    static func someEdge() -> Edge {
      let edge = Edge()
      edge.v1 = Primitives.someId()
      edge.v2 = Primitives.someId()
      edge.weight = Primitives.someFloat()
      return edge
    }

    static func somePlace() -> Place {
      let place = Place()
      place.descr = Primitives.someString()
      place.id = Primitives.someId()
      place.latitude = Primitives.someLatitude()
      place.longitude = Primitives.someLongitude()
      place.type = Primitives.someString()
      return place
    }

    static func someSyncInfoOfConcreteBuilding(_ id: Int) -> SyncInfo {
      let someSyncInfo = IU.Entity.someSyncInfo()
      someSyncInfo.isSyncOfConcreteBuilding = true
      someSyncInfo.buildingId.value = id
      return someSyncInfo
    }

    static func someSyncInfoOfList() -> SyncInfo {
      let someSyncInfo = IU.Entity.someSyncInfo()
      someSyncInfo.isSyncOfConcreteBuilding = false
      return someSyncInfo
    }

    static func someSyncInfo() -> SyncInfo {
      let syncInfo = SyncInfo()
      syncInfo.buildingId.value = Primitives.someId()
      syncInfo.isSyncOfConcreteBuilding = Primitives.someBool()
      syncInfo.date = Primitives.someDate()
      return syncInfo
    }

    static func somePlaceUserInfo() -> PlaceUserInfo {
      let placeUserInfo = PlaceUserInfo()
      placeUserInfo.id = Primitives.someId()
      placeUserInfo.descr = Primitives.someString()
      placeUserInfo.isFavourite = Primitives.someBool()
      placeUserInfo.recentDate = Primitives.someDate()
      return placeUserInfo
    }
  }

  enum Primitives {
    static func someBool() -> Bool {
      return faker.number.randomBool()
    }

    static func someDate() -> Date {
      return Date(timeIntervalSince1970: TimeInterval(arc4random_uniform(UInt32.max)))
    }

    static func someString() -> String {
      return faker.internet.ipV6Address()
    }

    static func someInt() -> Int {
      return faker.number.randomInt()
    }

    static func someId() -> Int {
      return faker.number.increasingUniqueId()
    }

    static func someCGFloat() -> CGFloat {
      return faker.number.randomCGFloat()
    }

    static func someDouble() -> Double {
      return faker.number.randomDouble()
    }

    static func someFloat() -> Float {
      return faker.number.randomFloat()
    }

    static func randomLetter() -> String {
      return faker.lorem.character()
    }

    static func someLongitude() -> Double {
      return faker.address.longitude()
    }

    static func someLatitude() -> Double {
      return faker.address.latitude()
    }

    static func someImageUrl() -> String {
      return faker.internet.image()
    }
  }
}

typealias IU = InstantiateUtils

typealias IUE = InstantiateUtils.Entity
typealias IUC = InstantiateUtils.Collections
typealias IUP = InstantiateUtils.Primitives

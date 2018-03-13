//
//  PlaceUserInfo.swift
//  Beacons
//
//  Created by Антон Назаров on 11.10.2017.
//  Copyright © 2017 com.epam All rights reserved.
//

import RealmSwift
import ObjectMapper

@objcMembers class PlaceUserInfo: Object {
  dynamic var descr: String = ""
  dynamic var id: Int = 0
  dynamic var isFavourite: Bool = false
  dynamic var recentDate: Date?

  override class func primaryKey() -> String? {
    return #keyPath(PlaceUserInfo.id)
  }

  required convenience init?(map: Map) {
    self.init()
  }
}

extension PlaceUserInfo: Mappable {
  func mapping(map: Map) {
    id <- map["id"]
    descr <- map["descr"]
    isFavourite <- map["isFavourite"]
    recentDate <- map["recentDate"]
  }
}

//
//  SyncInfo.swift
//  Beacons
//
//  Created by Антон Назаров on 22/11/2017.
//  Copyright © 2017 com.epam All rights reserved.
//

import RealmSwift

@objcMembers class SyncInfo: Object {
  dynamic var date = Date()
  dynamic var isSyncOfConcreteBuilding = false
  dynamic var buildingId = RealmOptional<Int>()

  override class func indexedProperties() -> [String] {
    return [#keyPath(SyncInfo.date)]
  }
}

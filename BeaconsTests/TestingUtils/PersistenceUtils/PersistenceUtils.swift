//
//  PersistenceUtils.swift
//  BeaconsTests
//
//  Created by Антон Назаров on 10.10.2017.
//  Copyright © 2017 com.epam All rights reserved.
//

import RealmSwift
import ObjectMapper
@testable import Beacons

enum PersistenceUtils {
  static func fillVertexes() {
    let realm = try! Realm()
    try! realm.write {
      Mapper<Vertex>().mapArray(JSONString: TestUtils.getJSON(name: "vertex"))!.forEach {
        realm.add($0, update: false)
      }
    }
  }

  static func clearDB() {
    let realm = try! Realm()
    if realm.isInWriteTransaction {
      realm.deleteAll()
    } else {
      try! realm.write(realm.deleteAll)
    }
  }
}

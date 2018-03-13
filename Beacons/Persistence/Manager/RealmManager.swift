//
//  RealmManager.swift
//  Beacons
//
//  Created by Антон Назаров on 15.11.2017.
//  Copyright © 2017 com.epam. All rights reserved.
//

import RealmSwift

class RealmManager {
  private var realm: Realm {
    do {
      return try Realm()
    } catch {
      fatalError("Can't get realm reference")
    }
  }

  func submit<T>(_ query: (_ realm: Realm) -> T) -> T {
    return query(realm)
  }

  func execute(_ query: (_ realm: Realm) throws -> Void) throws {
    try query(realm)
  }
}

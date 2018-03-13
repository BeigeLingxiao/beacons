//
//  Utils.swift
//  Beacons
//
//  Created by Антон Назаров on 29.09.17.
//  Copyright © 2017 com.epam All rights reserved.
//

import Foundation
import RealmSwift

enum Utils {
  static func getJSON(name: String) -> String {
    do {
      return try String(contentsOfFile: path(name: name, type: "json"), encoding: .utf8)
    } catch {
      fatalError("Can't read \(name)")
    }
  }

  static func getGif(name: String) -> Data {
    do {
      return try Data(contentsOf: URL(fileURLWithPath: path(name: name, type: "gif")))
    } catch {
      fatalError("Can't read \(name)")
    }
  }

  static func path(name: String, type: String) -> String {
    guard let path = Bundle.main.path(forResource: name, ofType: type) else {
      fatalError("Error while reading \(name)")
    }
    return path
  }

  static func clearDB() {
    try? Realm().write {
      try Realm().deleteAll()
    }
  }
}

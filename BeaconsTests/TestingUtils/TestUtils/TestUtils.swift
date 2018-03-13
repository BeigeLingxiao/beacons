//
//  TestUtils.swift
//  BeaconsTests
//
//  Created by Антон Назаров on 29.09.17.
//  Copyright © 2017 com.epam All rights reserved.
//

import RealmSwift
import ObjectMapper
import Swinject
@testable import Beacons

class TestUtils {
  static let resolver = Beacons.AppDelegate().assembly.resolver

  static func getJSON(name: String) -> String {
    guard let path = Bundle(for: TestUtils.self).path(forResource: name, ofType: "json") else {
      fatalError("Error while reading \(name)")
    }
    return try! String(contentsOfFile: path, encoding: .utf8)
  }
}

//
//  Configuration.swift
//  Beacons
//
//  Created by Антон Назаров on 02.11.2017.
//  Copyright © 2017 com.epam All rights reserved.
//

enum Configuration {
  //swiftlint:disable:next force_cast force_unwrapping
  private static let apiEndpoint = Bundle.main.infoDictionary![UserDefaultKeys.endpoint] as! String
  //swiftlint:disable:next force_cast force_unwrapping
  static let ENVIROMENT = Bundle.main.infoDictionary![UserDefaultKeys.env] as! String
  static let BANNER = Configuration.getBanner()

  static func url(for endpoint: String) -> String {
    return Configuration.apiEndpoint + endpoint
  }
}

// MARK: - Banner
private extension Configuration {
  static func getBanner() -> String {
    switch Configuration.ENVIROMENT {
    case "Test":
      return Banner.TEST.rawValue
    case "Dev":
      return Banner.DEV.rawValue
    default:
      fatalError("No enviroment")
    }
  }
}

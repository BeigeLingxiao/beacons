//
//  Endpoint.swift
//  Beacons
//
//  Created by Антон Назаров on 09.11.2017.
//  Copyright © 2017 com.epam All rights reserved.
//

enum Endpoint: String {
  case buildings = "/rest/buildings"
  case floors = "/rest/building/"

  static func building(_ id: Int) -> String {
    return Endpoint.floors.rawValue + "\(id)"
  }
}

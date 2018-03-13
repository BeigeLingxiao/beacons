//
//  FloorServiceTestImpl.swift
//  Beacons
//
//  Created by Антон Назаров on 09/01/2018.
//  Copyright © 2018 com.epam. All rights reserved.
//

import ObjectMapper

class FloorServiceTestImpl: FloorService {
  func replace(floors: [Floor], inBuilding id: Int) -> [Floor] {
    return floors
  }

  func get(number: String, fromBuilding id: Int) -> Floor {
    return Mapper<Floor>().mapArray(JSONString: Utils.getJSON(name: "MockedFloor"))![0]
  }
}

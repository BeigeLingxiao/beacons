//
//  FloorService.swift
//  Beacons
//
//  Created by Антон Назаров on 04.11.2017.
//  Copyright © 2017 com.epam All rights reserved.
//

protocol FloorService {
  func replace(floors: [Floor], inBuilding id: Int) -> [Floor]

  func get(number: String, fromBuilding id: Int) -> Floor
}

//
//  EdgeService.swift
//  Beacons
//
//  Created by Антон Назаров on 07.11.2017.
//  Copyright © 2017 com.epam All rights reserved.
//

protocol EdgeService {
  func getAll(fromBuilding id: Int) -> [Edge]
}

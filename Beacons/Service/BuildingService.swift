//
//  MarkerLoader.swift
//  Beacons
//
//  Created by Антон Назаров on 26.09.17.
//  Copyright © 2017 com.epam All rights reserved.
//

import RealmSwift
import RxSwift

protocol BuildingService {
  func get(by id: Int) -> Observable<Building>

  func replaceAll(_ buildings: [Building]) -> [Building]

  func getAll() -> Observable<Results<Building>>
}

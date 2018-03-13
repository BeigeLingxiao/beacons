//
//  PlaceService.swift
//  Beacons
//
//  Created by Антон Назаров on 16.10.2017.
//  Copyright © 2017 com.epam All rights reserved.
//

import RxSwift
import RealmSwift

protocol PlaceService {
  func get(by id: Int) -> Place

  func search(inBuilding id: Int, query: String) -> Observable<[Place]>
}

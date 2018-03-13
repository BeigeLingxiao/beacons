//
//  PlaceServiceImpl.swift
//  Beacons
//
//  Created by Антон Назаров on 17.10.2017.
//  Copyright © 2017 com.epam All rights reserved.
//

import RxSwift
import RxRealm

class PlaceServiceImpl: PlaceService {
  private let placeRepository: PlaceRepository
  private let placeUserInfoRepository: PlaceUserInfoRepository

  init(placeRepository: PlaceRepository, placeUserInfoRepository: PlaceUserInfoRepository) {
    self.placeRepository = placeRepository
    self.placeUserInfoRepository = placeUserInfoRepository
  }

  func search(inBuilding id: Int, query: String) -> Observable<[Place]> {
    return  Observable.array(from: placeRepository.search(query: query))
      .map { $0.filter { $0.floor.building.id == id } }
  }

  func get(by id: Int) -> Place {
    guard let place = placeRepository.get(by: id) else {
      fatalError("id = \(id)")
    }
    return place
  }
}

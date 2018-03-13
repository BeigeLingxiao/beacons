//
//  PlaceUserInfoServiceImpl.swift
//  Beacons
//
//  Created by Антон Назаров on 02/01/2018.
//  Copyright © 2018 com.epam. All rights reserved.
//

import RxSwift

class PlaceUserInfoServiceImpl: PlaceUserInfoService {
  private let placeUserInfoRepository: PlaceUserInfoRepository

  init(placeUserInfoRepository: PlaceUserInfoRepository) {
    self.placeUserInfoRepository = placeUserInfoRepository
  }

  func getType(by id: Int) -> PlaceType {
    switch (isFavourite(id: id), isRecent(id: id)) {
    case (false, true):
      return .recent
    case (false, false):
      return .usual
    default:
      return .favourite
    }
  }

  private func isFavourite(id: Int) -> Bool {
    return placeUserInfoRepository.isFavourite(id: id)
  }

  private func isRecent(id: Int) -> Bool {
    return false
  }

  func toggleFavourite(id: Int) {
    do {
      _ = try placeUserInfoRepository.toggleFavourite(id: id)
    } catch {
      log.error("Place is not found")
    }
  }

  func addToHistory(id: Int) -> Int {
    return 1
  }

  func getRecent(limit: Int) -> Observable<[Place]> {
    return Observable.just([Place]())
  }
}

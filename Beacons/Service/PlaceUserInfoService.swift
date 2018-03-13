//
//  PlaceUserInfoService.swift
//  Beacons
//
//  Created by Антон Назаров on 02/01/2018.
//  Copyright © 2018 com.epam. All rights reserved.
//

import RxSwift

protocol PlaceUserInfoService {
  func getType(by id: Int) -> PlaceType

  func toggleFavourite(id: Int)

  func addToHistory(id: Int) -> Int

  func getRecent(limit: Int) -> Observable<[Place]>
}

//
//  NetworkService.swift
//  Beacons
//
//  Created by Антон Назаров on 09.11.2017.
//  Copyright © 2017 com.epam All rights reserved.
//

import RxSwift

protocol NetworkService {
  func getBuildings() -> Single<[Building]>

  func getFloors(ofBuilding: Int) -> Single<[Floor]>
}

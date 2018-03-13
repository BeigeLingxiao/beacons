//
//  NetworkServiceTestImpl.swift
//  Beacons
//
//  Created by Антон Назаров on 09.11.2017.
//  Copyright © 2017 com.epam All rights reserved.
//

import RxSwift

class NetworkServiceTestImpl: NetworkService {
  func getBuildings() -> Single<[Building]> {
    return Observable.empty().asSingle()
  }

  func getFloors(ofBuilding: Int) -> Single<[Floor]> {
    return Observable.empty().asSingle()
  }
}

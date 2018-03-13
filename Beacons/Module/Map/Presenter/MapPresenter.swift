//
//  MapPresenter.swift
//  Beacons
//
//  Created by Антон Назаров on 29.10.2017.
//  Copyright © 2017 com.epam All rights reserved.
//

import RxCocoa

class MapPresenter: MapPresentation {
  var markerPos: Driver<CLLocationCoordinate2D>

  init(state: State, buildingService: BuildingService) {
    markerPos = state.enteredBuildingId
      .flatMap(buildingService.get)
      .map { $0.pos }
      .asDriver(onErrorDriveWith: .never())
  }
}

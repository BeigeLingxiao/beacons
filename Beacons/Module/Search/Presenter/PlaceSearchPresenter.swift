//
//  PlaceSearchPresenter.swift
//  Beacons
//
//  Created by Антон Назаров on 23.10.2017.
//  Copyright © 2017 com.epam All rights reserved.
//

import RxSwift
import RxCocoa
import RxDataSources

class PlaceSearchPresenter: PlaceSearchPresentation {
  private let placeUserInfoService: PlaceUserInfoService
  private let placeService: PlaceService
  private let state: State

  init(placeService: PlaceService, placeUserInfoService: PlaceUserInfoService, state: State) {
    self.placeService = placeService
    self.state = state
    self.placeUserInfoService = placeUserInfoService
  }

  func search(query: Driver<String>) -> Driver<[PlaceSearchSection]> {
    return Observable.combineLatest(
      Observable.combineLatest(state.enteredBuildingId, query.asObservable())
        .flatMapLatest { [unowned self] in self.placeService.search(inBuilding: $0.0, query: $0.1) }
        .map { [unowned self] in
          $0.map {
            //swiftlint:disable:next line_length
            PlaceSearchTableViewCellDto(type: self.placeUserInfoService.getType(by: $0.id), title: $0.descr, subtitle: $0.type, id: $0.id)
          }
        }
        .map { PlaceSearchSection(header: "Places", items: $0) },
      self.placeUserInfoService.getRecent(limit: 10).map { _ in
        PlaceSearchSection(header: "History", items: [PlaceSearchTableViewCellDto]())
      }
    )
    .map {
      if $0.items.isEmpty {
        return [$1]
      } else {
        return [$0]
      }
    }.asDriver(onErrorJustReturn: [PlaceSearchSection]())
  }

  func choose(place: PlaceSearchTableViewCellDto) {
    _ = placeUserInfoService.addToHistory(id: place.id)
  }
}

//
//  PlaceServiceTestImpl.swift
//  Beacons
//
//  Created by Антон Назаров on 16.10.2017.
//  Copyright © 2017 com.epam All rights reserved.
//

import ObjectMapper
import RxSwift

class PlaceServiceTestImpl: PlaceService {
  private lazy var places = getPlaces()
  private static var placeUserInfos = [PlaceUserInfo]()
  static var __history = [PlaceSearchTableViewCellDto]()
  var _history = Variable<[PlaceSearchTableViewCellDto]>(PlaceServiceTestImpl.__history)
  var history: Observable<[PlaceSearchTableViewCellDto]>

  init() {
    history = _history.asObservable()
  }

  func toggleFavourite(id: Int) {
    if let place = PlaceServiceTestImpl.placeUserInfos.first(where: { $0.id == id }) {
      place.isFavourite = !place.isFavourite
    } else {
      let place = PlaceUserInfo()
      place.id = id
      place.isFavourite = true
      PlaceServiceTestImpl.placeUserInfos.append(place)
    }
  }

  func addToHistory(id: Int) {
    let place = places.first(where: { $0.id == id })!
    let dto = PlaceSearchTableViewCellDto(type: .recent, title: place.descr, subtitle: place.type, id: id)
    addToHistory(place: dto)
  }

  func addToHistory(place: PlaceSearchTableViewCellDto) {
    let tmp = PlaceSearchTableViewCellDto(type: .recent, title: place.title, subtitle: place.subtitle, id: place.id)
    PlaceServiceTestImpl.__history.insert(tmp, at: 0)
     PlaceServiceTestImpl.__history = PlaceServiceTestImpl.__history.unique
    _history.value = PlaceServiceTestImpl.__history
  }

  func getType(ofPlace id: Int) -> PlaceType {
    let place = PlaceServiceTestImpl.placeUserInfos.first(where: { $0.id == id })
    if let info = place, info.isFavourite {
      return .favourite
    }

    if _history.value.contains(where: { $0.id == id }) {
      return .recent
    }

    return .usual
  }

  func search(inBuilding id: Int, query: String) -> Observable<[Place]> {
    if query.isEmpty {
      return Observable.just([])
    }
    return Observable.just(places.filter { $0.descr.lowercased().contains(query.lowercased()) })
  }

  func get(by id: Int) -> Place {
    for place in places where place.id == id {
      return place
    }
    fatalError("Place not found id = \(id)")
  }

  private func getPlaces() -> [Place] {
    return Mapper<Place>().mapArray(JSONString: Utils.getJSON(name: "MockedPlace")) ?? []
  }
}

extension Array where Element : Equatable {
  var unique: [Element] {
    var uniqueValues: [Element] = []
    forEach { item in
      if !uniqueValues.contains(item) {
        uniqueValues += [item]
      }
    }
    return uniqueValues
  }
}

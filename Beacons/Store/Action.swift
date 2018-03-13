//
//  Action.swift
//  Beacons
//
//  Created by Антон Назаров on 14/12/2017.
//  Copyright © 2017 com.epam. All rights reserved.
//

// Action which only change global state (which are shared between modules) of app
enum Action {
  case enterBuilding(id: Int)
  case enterFloor(number: String)
  case choosePlace(id: Int?)
  case moveTo(pos: CLLocationCoordinate2D)
  case networkError(_: NetworkError)
  case businessError(_: BusinessError)
}

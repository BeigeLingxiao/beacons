//
//  State.swift
//  Beacons
//
//  Created by Антон Назаров on 07/12/2017.
//  Copyright © 2017 com.epam. All rights reserved.
//

import RxSwift

class State {
  private let _enteredBuildingId = ReplaySubject<Int>.create(bufferSize: 1)
  private let _enteredFloor = ReplaySubject<String>.create(bufferSize: 1)
  private let _choosenPlaceId = ReplaySubject<StateType<Int>>.create(bufferSize: 1)
  private let _position = ReplaySubject<CLLocationCoordinate2D>.create(bufferSize: 1)

  // All states changing only from view layer except position. Because we calculate the position, and we want to share
  // it between modules. That's the only exception from uni-directional dataflow. During position's alghoritmh development
  // i had to write a lot of code wit bad smells,which break architecture.That's why i decided, that it should be in own module.
  let enteredBuildingId: Observable<Int>
  let enteredFloor: Observable<String>
  let choosenPlaceId: Observable<StateType<Int>>
  let position: Observable<CLLocationCoordinate2D>

  init() {
    enteredBuildingId = _enteredBuildingId.asState(identifier: "building")
    enteredFloor = _enteredFloor.asState(identifier: "floor")
    choosenPlaceId = _choosenPlaceId.asState(identifier: "place")
    position = _position.asState(identifier: "position")
  }

  func dispatch(_ action: Action) {
    switch action {
    case .enterBuilding(let id):
      _enteredBuildingId.onNext(id)
    case .enterFloor(let number):
      _enteredFloor.onNext(number)
    case .choosePlace(let id):
      if let id = id {
        _choosenPlaceId.onNext(StateType(id))
      } else {
        _choosenPlaceId.onNext(.notChoosen)
      }
    case .moveTo(let pos):
      _position.onNext(pos)
    default:
      fatalError("Unexpected action")
    }
  }
}

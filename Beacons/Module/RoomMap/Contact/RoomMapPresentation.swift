//
//  RoomMapPresentation.swift
//  Beacons
//
//  Created by Антон Назаров on 15.10.2017.
//  Copyright © 2017 com.epam All rights reserved.
//

import RxSwift
import RxCocoa

protocol RoomMapPresentation {
  var enteredBuilding: Observable<Building> { get }
  var enteredFloor: Driver<String> { get }
  var currentOverlay: Driver<GMSGroundOverlay> { get }
  var currentPath: Driver<GMSPath> { get }

  func addToFavourite(click: Observable<()>) -> Disposable
}

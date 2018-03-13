//
//  RoomMapViewAssembly.swift
//  Beacons
//
//  Created by Антон Назаров on 12.10.2017.
//  Copyright © 2017 com.epam. All rights reserved.
//

import Swinject
import SwinjectAutoregistration

class RoomMapViewAssembly: Assembly {
  func assemble(container: Container) {
    container.register(RoomMapViewController.self) {
      let controller = RoomMapViewController(nibName: nil, bundle: nil)
      controller.roomMapPresenter = $0 ~> RoomMapPresentation.self
      controller.positionInteractor = $0 ~> PositionInteractor.self
      return controller
    }.initCompleted { resolver, controller in
        controller.searchWireframe = resolver ~> PlaceSearchWireframe.self
    }
  }
}

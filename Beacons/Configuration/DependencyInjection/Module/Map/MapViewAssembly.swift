//
//  MapViewAssembly.swift
//  Beacons
//
//  Created by Антон Назаров on 29.10.2017.
//  Copyright © 2017 com.epam. All rights reserved.
//

import Swinject
import SwinjectAutoregistration

class MapViewAssembly: Assembly {
  func assemble(container: Container) {
    container.register(MapViewController.self) {
      let controller = MapViewController(nibName: nil, bundle: nil)
      controller.mapPresenter = $0 ~> MapPresentation.self
      return controller
    }
  }
}

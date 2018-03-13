//
//  BuildingView.swift
//  Beacons
//
//  Created by Антон Назаров on 28.10.2017.
//  Copyright © 2017 com.epam. All rights reserved.
//

import Swinject
import SwinjectAutoregistration

class BuildingViewAssembly: Assembly {
  func assemble(container: Container) {
    container.register(BuildingListViewController.self) {
      let controller = BuildingListViewController(nibName: nil, bundle: nil)
      controller.roomMapWireframe = $0 ~> RoomMapWireframe.self
      controller.buildingListPresenter = $0 ~> BuildingListPresentation.self
      return controller
    }
  }
}

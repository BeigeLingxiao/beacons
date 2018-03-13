//
//  SearchViewAssembly.swift
//  Beacons
//
//  Created by Антон Назаров on 17.10.2017.
//  Copyright © 2017 com.epam. All rights reserved.
//

import Swinject
import SwinjectAutoregistration

class SearchViewAssembly: Assembly {
  func assemble(container: Container) {
    container.register(PlaceSearchViewController.self) {
      let controller = PlaceSearchViewController(nibName: nil, bundle: nil)
      controller.placeSearchPresenter = $0 ~> PlaceSearchPresentation.self
      return controller
    }
  }
}

//
//  SearchPresenterAssembly.swift
//  Beacons
//
//  Created by Антон Назаров on 17.10.2017.
//  Copyright © 2017 com.epam. All rights reserved.
//

import Swinject
import SwinjectAutoregistration

class SearchPresenterAssembly: Assembly {
  func assemble(container: Container) {
    container.autoregister(PlaceSearchPresentation.self, initializer: PlaceSearchPresenter.init)
  }
}

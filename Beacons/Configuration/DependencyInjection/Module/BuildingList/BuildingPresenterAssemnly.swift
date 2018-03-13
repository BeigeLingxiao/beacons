//
//  BuildingPresenterAssemnly.swift
//  Beacons
//
//  Created by Антон Назаров on 28.10.2017.
//  Copyright © 2017 com.epam. All rights reserved.
//

import Swinject
import SwinjectAutoregistration

class BuildingPresenterAssembly: Assembly {
  func assemble(container: Container) {
    container.autoregister(BuildingListPresentation.self, initializer: BuildingListPresenter.init)
  }
}

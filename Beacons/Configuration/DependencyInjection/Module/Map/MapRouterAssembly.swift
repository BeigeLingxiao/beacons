//
//  MapRouterAssembly.swift
//  Beacons
//
//  Created by Антон Назаров on 29.10.2017.
//  Copyright © 2017 com.epam. All rights reserved.
//

import Swinject
import SwinjectAutoregistration

class MapRouterAssembly: Assembly {
  func assemble(container: Container) {
    container.autoregister(MapWireframe.self, initializer: MapWireframe.init)
  }
}

//
//  SearchRouterAssembly.swift
//  Beacons
//
//  Created by Антон Назаров on 23.10.2017.
//  Copyright © 2017 com.epam. All rights reserved.
//

import Swinject
import SwinjectAutoregistration

class SearchRouterAssembly: Assembly {
  func assemble(container: Container) {
    container.register(PlaceSearchWireframe.self) {
      PlaceSearchWireframe(resolver: $0)
    }
  }
}

//
//  RoomMapRouterAssembly.swift
//  Beacons
//
//  Created by Антон Назаров on 16.10.2017.
//  Copyright © 2017 com.epam. All rights reserved.
//

import Swinject
import SwinjectAutoregistration

class RoomMapRouterAssembly: Assembly {
  func assemble(container: Container) {
    container.register(RoomMapWireframe.self) {
      RoomMapWireframe(resolver: $0)
    }
  }
}

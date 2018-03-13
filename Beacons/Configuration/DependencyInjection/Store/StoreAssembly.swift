//
//  StoreAssembly.swift
//  Beacons
//
//  Created by Антон Назаров on 07/12/2017.
//  Copyright © 2017 com.epam. All rights reserved.
//

import Swinject
import SwinjectAutoregistration

class StoreAssembly: Assembly {
  func assemble(container: Container) {
    container.autoregister(State.self, initializer: State.init).inObjectScope(.container)
  }
}

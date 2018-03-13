//
//  RoomMapInteractorAssembly.swift
//  Beacons
//
//  Created by Антон Назаров on 07.11.2017.
//  Copyright © 2017 com.epam. All rights reserved.
//

import Swinject
import SwinjectAutoregistration

class RoomMapInteractorAssembly: Assembly {
  func assemble(container: Container) {
    container.autoregister(FindWayInteractor.self, initializer: FindWayInteractorImpl.init)
    container.autoregister(PositionHandlingInteractor.self, initializer: PositionHandlingInteractorImpl.init)
#if MOCK
    container.autoregister(PositionInteractor.self, initializer: PositionInteractorTestImpl.init)
#else
    container.autoregister(PositionInteractor.self, initializer: PositionInteractorImpl.init)
#endif
  }
}

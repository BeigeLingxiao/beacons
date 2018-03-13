//
//  DemoServiceAssembly.swift
//  Beacons
//
//  Created by Антон Назаров on 18.10.2017.
//  Copyright © 2017 com.epam. All rights reserved.
//

import Alamofire
import Swinject
import SwinjectAutoregistration

class DemoServiceAssembly: Assembly {
  func assemble(container: Container) {
    container.autoregister(VertexService.self, initializer: VertexServiceTestImpl.init)

    container.autoregister(BuildingService.self, initializer: BuildingServiceTestImpl.init)

    container.autoregister(PlaceService.self, initializer: PlaceServiceTestImpl.init)

    container.autoregister(BeaconService.self, initializer: BeaconServiceTestImpl.init)

    container.autoregister(FloorService.self, initializer: FloorServiceTestImpl.init)

    container.autoregister(EdgeService.self, initializer: EdgeServiceTestImpl.init)

    container.autoregister(NetworkService.self, initializer: NetworkServiceTestImpl.init)

    container.autoregister(SyncInfoService.self, initializer: SyncInfoServiceTestImpl.init)

    container.autoregister(PlaceUserInfoService.self, initializer: PlaceUserInfoServiceImpl.init)

    container.register(SessionManager.self) { _ in
      SessionManager()
    }
  }
}

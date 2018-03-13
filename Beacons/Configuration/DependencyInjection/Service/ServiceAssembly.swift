//
//  ServiceAssembly.swift
//  Beacons
//
//  Created by Антон Назаров on 16.10.2017.
//  Copyright © 2017 com.epam. All rights reserved.
//

import Swinject
import SwinjectAutoregistration
import Alamofire

class ServiceAssembly: Assembly {
  func assemble(container: Container) {
    container.autoregister(VertexService.self, initializer: VertexServiceImpl.init)

    container.autoregister(BuildingService.self, initializer: BuildingServiceImpl.init)

    container.autoregister(PlaceService.self, initializer: PlaceServiceImpl.init)

    container.autoregister(BeaconService.self, initializer: BeaconServiceImpl.init)

    container.autoregister(FloorService.self, initializer: FloorServiceImpl.init)

    container.autoregister(EdgeService.self, initializer: EdgeServiceImpl.init)

    container.autoregister(NetworkService.self, initializer: NetworkServiceImpl.init)

    container.autoregister(SyncInfoService.self, initializer: SyncInfoServiceImpl.init)

    container.autoregister(PlaceUserInfoService.self, initializer: PlaceUserInfoServiceImpl.init)

    container.register(SessionManager.self) { _ in
      return Alamofire.SessionManager(
        configuration: URLSessionConfiguration.default.then {
          $0.timeoutIntervalForRequest = 10
        }
      )
    }
  }
}

//
//  PersistenceAssembly.swift
//  Beacons
//
//  Created by Антон Назаров on 09.10.2017.
//  Copyright © 2017 com.epam. All rights reserved.
//

import Swinject
import SwinjectAutoregistration
import RealmSwift

class PersistenceAssembly: Assembly {
  func assemble(container: Container) {
    Realm.Configuration.defaultConfiguration = Realm.Configuration(deleteRealmIfMigrationNeeded: true)

    container.autoregister(RealmManager.self, initializer: RealmManager.init)

    container.autoregister(VertexRepository.self, initializer: VertexRepository.init)

    container.autoregister(BuildingRepository.self, initializer: BuildingRepository.init)

    container.autoregister(FloorRepository.self, initializer: FloorRepository.init)

    container.autoregister(PlaceRepository.self, initializer: PlaceRepository.init)

    container.autoregister(EdgeRepository.self, initializer: EdgeRepository.init)

    container.autoregister(BeaconRepository.self, initializer: BeaconRepository.init)

    container.autoregister(SyncInfoRepository.self, initializer: SyncInfoRepository.init)

    container.autoregister(PlaceUserInfoRepository.self, initializer: PlaceUserInfoRepository.init)
  }
}

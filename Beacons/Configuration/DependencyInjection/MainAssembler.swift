//
//  DependencyContainer.swift
//  Beacons
//
//  Created by Антон Назаров on 28.09.17.
//  Copyright © 2017 com.epam. All rights reserved.
//

import Swinject

class MainAssembler {
  static func getAssemblies() -> [Assembly] {
    var assemblies: [Assembly] = [
      //Main
      PersistenceAssembly(),
      StoreAssembly(),
      //Map
      MapPresenterAssembly(),
      MapRouterAssembly(),
      MapViewAssembly(),
      //RoomMap
      RoomMapPresenterAssembly(),
      RoomMapRouterAssembly(),
      RoomMapViewAssembly(),
      RoomMapInteractorAssembly(),
      //Search
      SearchPresenterAssembly(),
      SearchRouterAssembly(),
      SearchViewAssembly(),
      //BuildingList
      BuildingPresenterAssembly(),
      BuildingViewAssembly()
    ]
    #if MOCK
      assemblies.append(DemoServiceAssembly())
    #else
      assemblies.append(ServiceAssembly())
    #endif
    return assemblies
  }
}

//
//  MapWireframe.swift
//  Beacons
//
//  Created by Антон Назаров on 29.10.2017.
//  Copyright © 2017 com.epam All rights reserved.
//

import Swinject
import SwinjectAutoregistration

class MapWireframe {
  private let resolver: Resolver

  init(resolver: Resolver) {
    self.resolver = resolver
  }

  func navigate(to controller: UINavigationController) {
  }
}

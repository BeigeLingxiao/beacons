//
//  PlaceSearchWireframe.swift
//  Beacons
//
//  Created by Антон Назаров on 23.10.2017.
//  Copyright © 2017 com.epam All rights reserved.
//

import Swinject
import SwinjectAutoregistration

class PlaceSearchWireframe {
  private let resolver: Resolver

  init(resolver: Resolver) {
    self.resolver = resolver
  }

  func present(to controller: UINavigationController?) {
    controller?.present(resolver ~> PlaceSearchViewController.self, animated: false)
  }
}

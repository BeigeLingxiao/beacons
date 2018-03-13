//
//  RoomMapWireframe.swift
//  Beacons
//
//  Created by Антон Назаров on 23.10.2017.
//  Copyright © 2017 com.epam All rights reserved.
//

import SwinjectAutoregistration
import Swinject

class RoomMapWireframe {
  private let resolver: Resolver

  init(resolver: Resolver) {
    self.resolver = resolver
  }

  func choosePathTo(place id: Int, from controller: PlaceSearchViewController) {
    controller.dismiss(animated: true, completion: nil)
  }

  func navigate(in navigationController: UINavigationController?) {
    navigationController?.pushViewController(resolver ~> RoomMapViewController.self, animated: true)
  }
}

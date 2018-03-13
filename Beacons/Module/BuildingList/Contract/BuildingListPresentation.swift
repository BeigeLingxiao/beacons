//
//  BuildingListPresentation.swift
//  Beacons
//
//  Created by Антон Назаров on 23.10.2017.
//  Copyright © 2017 com.epam All rights reserved.
//

import RxSwift
import RealmSwift

protocol BuildingListPresentation {
  var buildings: Observable<[BuildingListTableViewCellDto]> { get }

  func reloadBuildings()
}

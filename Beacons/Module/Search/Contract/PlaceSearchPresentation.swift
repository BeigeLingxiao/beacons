//
//  PlaceSearchPresentation.swift
//  Beacons
//
//  Created by Антон Назаров on 23.10.2017.
//  Copyright © 2017 com.epam All rights reserved.
//

import RxDataSources
import RxCocoa
import RxSwift

protocol PlaceSearchPresentation {
  func search(query: Driver<String>) -> Driver<[PlaceSearchSection]>

  func choose(place: PlaceSearchTableViewCellDto)
}

//
//  MapPresentation.swift
//  Beacons
//
//  Created by Антон Назаров on 29.10.2017.
//  Copyright © 2017 com.epam All rights reserved.
//

import RxCocoa

protocol MapPresentation {
  var markerPos: Driver<CLLocationCoordinate2D> { get }
}

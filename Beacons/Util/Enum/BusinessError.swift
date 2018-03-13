//
//  BusinessError.swift
//  Beacons
//
//  Created by Антон Назаров on 19/12/2017.
//  Copyright © 2017 com.epam. All rights reserved.
//

enum BusinessError: String, Error {
  case noFloors = "No floors in building"
  case noPlace = "No places on the floor"
}

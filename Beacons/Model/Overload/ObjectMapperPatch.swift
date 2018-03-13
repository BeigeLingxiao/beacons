//
//  ObjectMapperPatch.swift
//  Beacons
//
//  Created by Антон Назаров on 05.10.2017.
//  Copyright © 2017 com.epam All rights reserved.
//

import ObjectMapper
import RealmSwift

infix operator <-

public func <-<T: Mappable>(left: List<T>, right: Map) {
  var array: [T]?
  if right.mappingType == .toJSON {
    array = Array(left)
  }
  array <- right
  if right.mappingType == .fromJSON {
    if let theArray = array {
      left.append(objectsIn: theArray)
    }
  }
}

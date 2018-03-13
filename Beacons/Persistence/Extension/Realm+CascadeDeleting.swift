//
//  Realm+CascadeDeleting.swift
//  Beacons
//
//  Created by Антон Назаров on 01/12/2017.
//  Copyright © 2017 com.epam All rights reserved.
//

import Realm
import RealmSwift

/// TODO Please observe https://github.com/realm/realm-cocoa/issues/1186 - issue about cascade deleting in Realm.
/// Delete this after cascade deleting will officially released.
import RealmSwift
import Realm

protocol CascadeDeleting: class {
  func delete<S: Sequence>(_ objects: S, cascading: Bool) where S.Iterator.Element: Object
  func delete<Entity: Object>(_ entity: Entity, cascading: Bool)
}

extension Realm: CascadeDeleting {
  func delete<S: Sequence>(_ objects: S, cascading: Bool) where S.Iterator.Element: Object {
    objects.forEach { delete($0, cascading: cascading) }
  }

  func delete<Entity: Object>(_ entity: Entity, cascading: Bool) {
    if cascading {
      cascadeDelete(entity)
    } else {
      delete(entity)
    }
  }
}

private extension Realm {
  func cascadeDelete(_ entity: RLMObjectBase) {
    guard let entity = entity as? Object else {
      return
    }
    var toBeDeleted = Set<RLMObjectBase>()
    toBeDeleted.insert(entity)
    while !toBeDeleted.isEmpty {
      guard let element = toBeDeleted.removeFirst() as? Object,
        !element.isInvalidated else { continue }
      resolve(element: element, toBeDeleted: &toBeDeleted)
    }
  }

  func resolve(element: Object, toBeDeleted: inout Set<RLMObjectBase>) {
    element.objectSchema.properties.forEach {
      guard let value = element.value(forKey: $0.name) else {
        return
      }
      if let entity = value as? RLMObjectBase {
        toBeDeleted.insert(entity)
      } else if let list = value as? RealmSwift.ListBase {
        for index in 0..<list._rlmArray.count {
          //swiftlint:disable:next force_cast
          toBeDeleted.insert(list._rlmArray.object(at: index) as! RLMObjectBase)
        }
      }
    }
    delete(element)
  }
}

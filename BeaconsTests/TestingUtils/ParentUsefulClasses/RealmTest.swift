//
//  RealmTest.swift
//  BeaconsTests
//
//  Created by Антон Назаров on 30/11/2017.
//  Copyright © 2017 com.epam All rights reserved.
//

import Quick
import Nimble
import RealmSwift
import SwinjectAutoregistration
@testable import Beacons

class RealmTest: QuickSpec {
  private let buildingRepository = TestUtils.resolver ~> BuildingRepository.self
  /// Every test of repository layer need adding random building before itself (or every time writing
  /// 'realm.insert(IU.Entity...'). The main target of this property (and class) - remove all this boilerplate code.
  /// If u need building, already pasted in realm, u just call this one.
  /// However, if u don't use database, u shouldn't inherit this class
  var someBuildingFromRealm: Building {
    let building = IUE.someBuilding()
    let realm = try! Realm()
    try! realm.write {
      realm.add(building)
    }
    return building
  }

  var somePlaceUserInfoFromRealm: PlaceUserInfo {
    let placeUserInfo = IUE.somePlaceUserInfo()
    let realm = try! Realm()
    try! realm.write {
      realm.add(placeUserInfo)
    }
    return placeUserInfo
  }

  override func spec() {
    beforeSuite {
      Realm.Configuration.defaultConfiguration.inMemoryIdentifier = self.name
    }
    beforeEach {
      PersistenceUtils.clearDB()
    }
  }
}

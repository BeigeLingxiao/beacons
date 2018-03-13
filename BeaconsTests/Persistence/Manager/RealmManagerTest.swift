//
//  RealmManagerTest.swift
//  BeaconsTests
//
//  Created by Антон Назаров on 29/11/2017.
//  Copyright © 2017 com.epam All rights reserved.
//

import Quick
import Nimble
import RealmSwift
import SwinjectAutoregistration
@testable import Beacons

class RealmManagerTest: RealmTest {
  override func spec() {
    super.spec()
    let realmManager = TestUtils.resolver ~> RealmManager.self

    describe("Realm manager") {
      let someBuilding = IU.Entity.someBuilding()
      it("execute query") {
        try! realmManager.execute { realm in try realm.write { realm.add(someBuilding) } }

        expect(try! Realm().object(ofType: Building.self, forPrimaryKey: someBuilding.id)) == someBuilding
      }

      it("submit query") {
        expect(realmManager.submit { $0.objects(Building.self) }).to(beEmpty())
      }
    }
  }
}

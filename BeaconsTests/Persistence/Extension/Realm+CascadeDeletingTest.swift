//
//  Realm+CascadeDeletingTest.swift
//  BeaconsTests
//
//  Created by Антон Назаров on 01/12/2017.
//  Copyright © 2017 com.epam All rights reserved.
//

import Quick
import Nimble
import RealmSwift
import SwinjectAutoregistration
@testable import Beacons

class CascadeDeletingTest: RealmTest {
  override func spec() {
    super.spec()

    describe("Cascade deleting") {
      it("fail to delete cascade using standart api") {
        let someBuilding = self.someBuildingFromRealm
        let realm = try! Realm()

        expect(realm.objects(Vertex.self).count) > 0

        try! realm.write { realm.delete(someBuilding) }
        
        expect(realm.objects(Vertex.self).count) != 0
      }

      it("maintain cascade deleting") {
        let someBuilding = self.someBuildingFromRealm

        let realm = try! Realm()

        expect(realm.objects(Vertex.self).count) > 0

        try! realm.write { realm.delete(someBuilding, cascading: true) }

        expect(realm.objects(Vertex.self).count) == 0
      }
    }
  }
}

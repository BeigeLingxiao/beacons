//
//  BuildingRepositoryTest.swift
//  BeaconsTests
//
//  Created by Антон Назаров on 04.10.2017.
//  Copyright © 2017 com.epam All rights reserved.
//

import Quick
import Nimble
import RealmSwift
import RxRealm
import SwinjectAutoregistration
@testable import Beacons

class BuildingRepositoryTest: RealmTest {
  override func spec() {
    super.spec()
    let buildingRepository = TestUtils.resolver ~> BuildingRepository.self

    describe("Building repository") {
      it("add buildings") {
        let someBuildings = IU.Collections.someArray(IU.Entity.someBuilding)
        
        _ = try! buildingRepository.replaceAll(someBuildings)

        expect((try! Realm().objects(Building.self)).toArray()).to(contain(exactly: someBuildings, expect: ==))
      }

      it("delete existing before replace buildings") {
        _ = try! buildingRepository.replaceAll(IU.Collections.someArray(IU.Entity.someBuilding))
        let someBuildings = IU.Collections.someArray(IU.Entity.someBuilding)

        _ = try! buildingRepository.replaceAll(someBuildings)

        expect((try! Realm().objects(Building.self)).toArray()).to(contain(exactly: someBuildings, expect: ==))
      }

      it("return all buildings") {
        let someBuildings = try! buildingRepository.replaceAll(IU.Collections.someArray(IU.Entity.someBuilding))

        expect(buildingRepository.getAll().toArray()).to(contain(exactly: someBuildings, expect: ==))
      }

      it("get by id") {
        let expected = try! buildingRepository.replaceAll([IU.Entity.someBuilding()]).first!

        expect(buildingRepository.get(by: expected.id)) == expected
      }

      it("auto-update building result") {
        let buildings = buildingRepository.getAll()
        let someBuildings = IU.Collections.someArray(IU.Entity.someBuilding)

        _ = try! buildingRepository.replaceAll(someBuildings)

        expect(buildings.toArray()).to(contain(exactly: someBuildings, expect: ==))
      }
    }
  }
}

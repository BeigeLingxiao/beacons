//
//  BeaconRepositoryTest.swift
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

class BeaconRepositoryTest: RealmTest {
  override func spec() {
    super.spec()
    let beaconRepository = TestUtils.resolver ~> BeaconRepository.self

    describe("Beacon repository") {
      it("maintain beacons inverse relationship") {
        let someFloor = self.someBuildingFromRealm.floors[0]

        expect(someFloor.beacons[0].floor.number) == someFloor.number
      }

      it("return all beacons from concrete floor of concrete building") {
        let someBuilding = self.someBuildingFromRealm
        let someFloor = someBuilding.floors[0]

        expect(beaconRepository.getAll(fromBuilding: someBuilding.id, floor: someFloor.number))
          .to(contain(exactly: someFloor.beacons.toArray(), expect: ==))
      }
    }
  }
}

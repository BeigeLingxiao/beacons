//
//  PlaceRepositoryTest.swift
//  BeaconsTests
//
//  Created by Антон Назаров on 07.11.2017.
//  Copyright © 2017 com.epam All rights reserved.
//

import Quick
import Nimble
import RealmSwift
import SwinjectAutoregistration
@testable import Beacons

class PlaceRepositoryTest: RealmTest {
  override func spec() {
    super.spec()
    let placeRepository = TestUtils.resolver ~> PlaceRepository.self

    describe("Place repository") {
      it("maintain places inverse relationship") {
        let someFloor = self.someBuildingFromRealm.floors[0]

        expect(someFloor.places[0].floor.number) == someFloor.number
      }

      it("get by id") {
        let somePlace = self.someBuildingFromRealm.floors[0].places[0]

        expect(placeRepository.get(by: somePlace.id)) == somePlace
      }

      it("find all places from building") {
        let someBuilding = self.someBuildingFromRealm
        let expectedPlaces = self.places(from: someBuilding)

        expect(placeRepository.getAll(from: someBuilding.id)).to(contain(exactly: expectedPlaces, expect: ==))
      }
    }
  }
}

private extension PlaceRepositoryTest {
  func places(from building: Building) -> [Place] {
    return building.floors.flatMap { $0.places }
  }
}

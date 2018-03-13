//
//  EdgeRepositoryTest.swift
//  BeaconsTests
//
//  Created by Антон Назаров on 30/11/2017.
//  Copyright © 2017 com.epam All rights reserved.
//

import SwinjectAutoregistration
import Quick
import Nimble
import SwinjectAutoregistration
@testable import Beacons

class EdgeRepositoryTest: RealmTest {
  override func spec() {
    super.spec()
    let edgeRepository = TestUtils.resolver ~> EdgeRepository.self

    describe("Edge repository") {
      it("should maintain edges inverse relationship") {
        let someFloor = self.someBuildingFromRealm.floors[0]
        expect(someFloor.edges[0].floor.number) == someFloor.number
      }

      it("should find all places from building") {
        let someBuilding = self.someBuildingFromRealm
        let expectedEdges = self.edges(from: someBuilding)

        expect(edgeRepository.getAll(from: someBuilding.id)).to(contain(exactly: expectedEdges, expect: ==))
      }
    }
  }
}

private extension EdgeRepositoryTest {
  func edges(from building: Building) -> [Edge] {
    return building.floors.flatMap { $0.edges }
  }
}

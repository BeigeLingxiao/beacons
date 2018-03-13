//
//  VertexRepositoryTest.swift
//  BeaconsTests
//
//  Created by Антон Назаров on 09.10.2017.
//  Copyright © 2017 com.epam All rights reserved.
//

import Quick
import Nimble
import RealmSwift
import SwinjectAutoregistration
@testable import Beacons

class VertexRepositoryTest: RealmTest {
  override func spec() {
    super.spec()
    let vertexRepository = TestUtils.resolver ~> VertexRepository.self

    describe("Vertice repository") {
      it("maintain vertexes inverse relationship") {
        let someFloor = self.someBuildingFromRealm.floors[0]

        expect(someFloor.vertices[0].floor) == someFloor
      }

      it("find nearest vertex") {
        PersistenceUtils.fillVertexes()
        //near first vertex guaranty by test data
        let point = CLLocationCoordinate2DMake(91.4, -12.7)

        expect(vertexRepository.getNearest(to: point)!.id) == 1
      }

      it("get all from concrete building") {
        let someBuilding = self.someBuildingFromRealm
        let expectedVertices = self.vertices(in: someBuilding)

        expect(vertexRepository.getAll(fromBuilding: someBuilding.id)).to(contain(exactly: expectedVertices, expect: ==))
      }
    }
  }
}

private extension VertexRepositoryTest {
  func vertices(in building: Building) -> [Vertex] {
    return building.floors.flatMap { $0.vertices }
  }
}

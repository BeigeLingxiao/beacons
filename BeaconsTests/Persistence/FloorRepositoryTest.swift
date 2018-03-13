//
//  FloorRepositoryTest.swift
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

class FloorRepositoryTest: RealmTest {
  override func spec() {
    super.spec()
    let floorRepository = TestUtils.resolver ~> FloorRepository.self

    describe("Floor repository") {
      it("replace floors in building") {
        let someBuilding = self.someBuildingFromRealm
        let someFloors = IU.Collections.someArray(IU.Entity.someFloor)
        
        _ = try! floorRepository.replace(floors: someFloors, in: someBuilding.id)

        expect(someBuilding.floors.toArray()).to(contain(exactly: someFloors, expect: ==))
      }

      it("replace floors with similar primary key in building") {
        let someBuilding = self.someBuildingFromRealm
        let someFloors = self.getFloors(whichPrimaryKeysConflictingWith: someBuilding.floors)

        _ = try! floorRepository.replace(floors: someFloors, in: someBuilding.id)

        expect(someBuilding.floors.toArray()).to(contain(exactly: someFloors, expect: ==))
      }

      it("return concrete floor from concrete building") {
        let someBuilding = self.someBuildingFromRealm
        let someFloor = someBuilding.floors[0]

        expect(floorRepository.get(number: someFloor.number, from: someBuilding.id)) == someFloor
      }

      it("maintain floor inverse relationship") {
        let someBuilding = self.someBuildingFromRealm
        expect(someBuilding.floors[0].building.id) == someBuilding.id
      }

      it("maintain floor inverse relationship after floors replacement") {
        let someBuilding = self.someBuildingFromRealm
        let someFloor = IU.Entity.someFloor()

        _ = try! floorRepository.replace(floors: [someFloor], in: someBuilding.id)

        expect(floorRepository.get(number: someFloor.number, from: someBuilding.id)?.building) == someBuilding
        expect(someFloor.building) == someBuilding
      }
    }
  }
}

private extension FloorRepositoryTest {
  func getFloors(whichPrimaryKeysConflictingWith floors: List<Floor>) -> [Floor] {
    let someFloor = IU.Entity.someFloor()
    someFloor.places.append(
      objectsIn: floors
        .flatMap { $0.places }
        .map { $0.id }
        .map {
          let somePlace = IU.Entity.somePlace()
          somePlace.id = $0
          return somePlace
        })
    return [someFloor]
  }
}

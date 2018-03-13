//
//  BuildingServiceTest.swift
//  BeaconsTests
//
//  Created by Антон Назаров on 18.10.2017.
//  Copyright © 2017 com.epam All rights reserved.
//

import Quick
import Nimble
import Cuckoo
import RealmSwift
import SwinjectAutoregistration
@testable import Beacons

class BuildingServiceTest: CuckooTest {
  override func spec() {
    super.spec()
    let mockBuildingRepo = MockBuildingRepository(realmManager: TestUtils.resolver ~> RealmManager.self)
    register(mock: mockBuildingRepo)
    let buildingService: BuildingService = BuildingServiceImpl(buildingRepository: mockBuildingRepo)

    describe("Building service test") {
      context("mocked repository") {
        it("invoke BuildingRepository.getAll method") {
          stub(mockBuildingRepo) { when($0.getAll()).thenReturn(try! Realm().objects(Building.self)) }

          _ = buildingService.getAll()

          verify(mockBuildingRepo, once()).getAll()
        }

        it("invoke BuildingRepository.replaceAll method") {
          stub(mockBuildingRepo) { when($0.replaceAll(any(Array.self))).thenReturn([Building]()) }

          _ = buildingService.replaceAll(IUC.someArray(IUE.someBuilding))

          verify(mockBuildingRepo, once()).replaceAll(any(Array.self))
        }

        it("invoke fatalError if BuildingRepository.replaceAll threw") {
          stub(mockBuildingRepo) { when($0.replaceAll(any(Array.self))).thenThrow(MockError.Realm) }

          expect { _ = buildingService.replaceAll(IUC.someArray(IUE.someBuilding)) }.to(throwAssertion())
        }

        it("invoke BuildingRepository.getBy method") {
          stub(mockBuildingRepo) { when($0.get(by: any(Int.self))).thenReturn(IUE.someBuilding()) }

          _ = buildingService.get(by: IU.Primitives.someId())

          verify(mockBuildingRepo, once()).get(by: any(Int.self))
        }

        it("invoke fatalError if BuildingRepository.getBy return nil") {
          stub(mockBuildingRepo) { when($0.get(by: any(Int.self))).thenReturn(nil) }

          expect { _ = buildingService.get(by: IUP.someId()) }.to(throwAssertion())
        }
      }
    }
  }
}

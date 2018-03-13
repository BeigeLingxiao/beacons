//
//  SyncInfoRepositoryTest.swift
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

class SyncInfoRepositoryTest: RealmTest {
  override func spec() {
    super.spec()
    let syncInfoRepository = TestUtils.resolver ~> SyncInfoRepository.self

    describe("SyncInfo repository") {
      context("empty databse") {
        it("add syncInfo") {
          let someSyncInfo = IU.Entity.someSyncInfo()

          _ = try! syncInfoRepository.add(someSyncInfo)

          expect((try! Realm().objects(SyncInfo.self)).toArray()).to(contain(exactly: [someSyncInfo], expect: ==))
        }

        it("return empty Result of concrete building sync") {
          expect(syncInfoRepository.getAllOfBuildingSortedDescByDate(IU.Primitives.someId()).toArray()).to(beEmpty())
        }

        it("return empty Result of building list sync") {
          expect(syncInfoRepository.getAllOfBuildingListSortedDescByDate().toArray()).to(beEmpty())
        }
      }

      context("filled database") {
        it("return sorted by date desc Result of list sync") {
          let someSyncInfos = IU.Collections.someArray(IU.Entity.someSyncInfoOfList) +
            IU.Collections.someArray { IU.Entity.someSyncInfoOfConcreteBuilding(IU.Primitives.someId()) }

          someSyncInfos.forEach { _ = try! syncInfoRepository.add($0) }

          expect(syncInfoRepository.getAllOfBuildingListSortedDescByDate().toArray())
            .to(contain(exactly: self.getAllSyncOfListSortedDescByDate(someSyncInfos), expect: ==))
        }

        it("sorted by date desc Result of concrete building sync") {
          let someId = IU.Primitives.someId()
          let someSyncInfos = IU.Collections.someArray(IU.Entity.someSyncInfoOfList) +
            IU.Collections.someArray { IU.Entity.someSyncInfoOfConcreteBuilding(someId) }

          someSyncInfos.forEach { _ = try! syncInfoRepository.add($0) }

          expect(syncInfoRepository.getAllOfBuildingSortedDescByDate(someId).toArray())
            .to(contain(exactly: self.getAllOfConcreteBuildingSortedDescByDate(someSyncInfos, someId), expect: ==))
        }

        it("auto-update sorted by date desc Result of list sync") {
          let someSyncInfos = IU.Collections.someArray(IU.Entity.someSyncInfoOfList)
          someSyncInfos.forEach { _ = try! syncInfoRepository.add($0) }

          let someNewSyncInfo = try! syncInfoRepository.add(IU.Entity.someSyncInfo())

          expect(syncInfoRepository.getAllOfBuildingListSortedDescByDate().toArray())
            .to(contain(exactly: self.getAllSyncOfListSortedDescByDate(someSyncInfos + [someNewSyncInfo]), expect: ==))
        }

        it("auto-update sorted by date desc Result of concrete building sync") {
          let someId = IU.Primitives.someId()
          let someSyncInfos = IU.Collections.someArray { IU.Entity.someSyncInfoOfConcreteBuilding(someId) }
          
          someSyncInfos.forEach { _ = try! syncInfoRepository.add($0) }
          let someNewSyncInfo = try! syncInfoRepository.add(IU.Entity.someSyncInfoOfConcreteBuilding(someId))

          expect(syncInfoRepository.getAllOfBuildingSortedDescByDate(someId).toArray())
            .to(contain(exactly: self.getAllOfConcreteBuildingSortedDescByDate(someSyncInfos + [someNewSyncInfo], someId), expect: ==))
        }
      }
    }
  }
}

private extension SyncInfoRepositoryTest {
  func getAllSyncOfListSortedDescByDate(_ syncInfos: [SyncInfo]) -> [SyncInfo] {
    return syncInfos
      .filter { !$0.isSyncOfConcreteBuilding }
      .sorted { $0.date > $1.date }
  }

  func getAllOfConcreteBuildingSortedDescByDate(_ syncInfos: [SyncInfo], _ id: Int) -> [SyncInfo] {
    return syncInfos
      .filter { $0.isSyncOfConcreteBuilding && $0.buildingId.value == id }
      .sorted { $0.date > $1.date }
  }
}


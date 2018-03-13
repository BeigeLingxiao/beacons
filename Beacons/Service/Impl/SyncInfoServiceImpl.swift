//
//  SyncInfoServiceImpl.swift
//  Beacons
//
//  Created by Антон Назаров on 22/11/2017.
//  Copyright © 2017 com.epam. All rights reserved.
//

import RxSwift
import RxRealm

class SyncInfoServiceImpl: SyncInfoService {
  private let syncInfoRepository: SyncInfoRepository

  init(syncInfoRepository: SyncInfoRepository) {
    self.syncInfoRepository = syncInfoRepository
  }

  func isListSyncNeeded() -> Observable<Void> {
    return Observable.collection(from: syncInfoRepository.getAllOfBuildingListSortedDescByDate())
      .filter { $0.isEmpty }
      .map { _ in Void() }
  }

  func isBuildingSyncNeeded(_ id: Int) -> Observable<Void> {
    return Observable.collection(from: syncInfoRepository.getAllOfBuildingSortedDescByDate(id))
      .filter { $0.isEmpty }
      .map { _ in Void() }
  }

  func add() -> SyncInfo {
    do {
      return try syncInfoRepository.add(SyncInfo().then {
        $0.isSyncOfConcreteBuilding = false
        $0.date = Date()
      })
    } catch {
      fatalError("_")
    }
  }

  func add(_ id: Int) -> SyncInfo {
    do {
      return try syncInfoRepository.add(SyncInfo().then {
        $0.isSyncOfConcreteBuilding = true
        $0.date = Date()
        $0.buildingId.value = id
      })
    } catch {
      fatalError("\(id)")
    }
  }
}

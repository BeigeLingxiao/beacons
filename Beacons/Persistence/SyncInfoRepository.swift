//
//  SyncInfoRepository.swift
//  Beacons
//
//  Created by Антон Назаров on 22/11/2017.
//  Copyright © 2017 com.epam. All rights reserved.
//

import RealmSwift

class SyncInfoRepository {
  private let realmManager: RealmManager

  init(realmManager: RealmManager) {
    self.realmManager = realmManager
  }

  func getAllOfBuildingListSortedDescByDate() -> Results<SyncInfo> {
    return realmManager.submit {
      $0.objects(SyncInfo.self)
        .filter("NOT (isSyncOfConcreteBuilding == true)")
        .sorted(byKeyPath: "date", ascending: false)
    }
  }

  func getAllOfBuildingSortedDescByDate(_ id: Int) -> Results<SyncInfo> {
    return realmManager.submit {
      $0.objects(SyncInfo.self)
        .filter("(isSyncOfConcreteBuilding == true) AND (buildingId != nil) AND (buildingId  == %@)", id)
        .sorted(byKeyPath: "date", ascending: false)
    }
  }

  func add(_ syncInfo: SyncInfo) throws -> SyncInfo {
    try realmManager.execute { realm in
      try realm.write {
        realm.add(syncInfo)
      }
    }
    return syncInfo
  }
}

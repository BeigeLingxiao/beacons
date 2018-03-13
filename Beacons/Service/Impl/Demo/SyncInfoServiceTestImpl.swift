//
//  SyncInfoServiceTestImpl.swift
//  Beacons
//
//  Created by Антон Назаров on 09/01/2018.
//  Copyright © 2018 com.epam. All rights reserved.
//

import RxSwift

class SyncInfoServiceTestImpl: SyncInfoService {
  func isListSyncNeeded() -> Observable<Void> {
    return Observable<()>.never()
  }

  func isBuildingSyncNeeded(_ id: Int) -> Observable<Void> {
    return Observable<()>.never()
  }

  func add() -> SyncInfo {
    return SyncInfo()
  }

  func add(_ id: Int) -> SyncInfo {
    return add()
  }
}

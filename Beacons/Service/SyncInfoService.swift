//
//  SyncInfoService.swift
//  Beacons
//
//  Created by Антон Назаров on 22/11/2017.
//  Copyright © 2017 com.epam. All rights reserved.
//

import RxSwift

protocol SyncInfoService {
  func isListSyncNeeded() -> Observable<Void>

  func isBuildingSyncNeeded(_ id: Int) -> Observable<Void>

  func add() -> SyncInfo

  func add(_ id: Int) -> SyncInfo
}

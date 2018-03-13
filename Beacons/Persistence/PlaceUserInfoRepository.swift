//
//  PlaceUserInfoRepository.swift
//  Beacons
//
//  Created by Антон Назаров on 26/12/2017.
//  Copyright © 2017 com.epam. All rights reserved.
//

import RealmSwift

class PlaceUserInfoRepository {
  private let realmManager: RealmManager

  init(realmManager: RealmManager) {
    self.realmManager = realmManager
  }

  func isFavourite(id: Int) -> Bool {
    return realmManager.submit { $0.object(ofType: PlaceUserInfo.self, forPrimaryKey: id)?.isFavourite ?? false }
  }

  func toggleFavourite(id: Int) throws {
    try realmManager.execute { realm in
      try realm.write {
        guard let placeUserInfo = get(by: id) else {
          realm.add(PlaceUserInfo().then {
            $0.id = id
            $0.isFavourite = true
          })
          return
        }
        placeUserInfo.isFavourite = !placeUserInfo.isFavourite
      }
    }
  }

  func updateDate(id: Int) throws {
    try realmManager.execute { realm in
      try realm.write {
        guard let placeUserInfo = get(by: id) else {
          realm.add(PlaceUserInfo().then {
            $0.id = id
            $0.recentDate = Date()
          })
          return
        }
        placeUserInfo.recentDate = Date()
      }
    }
  }

  func getRecent() -> Results<PlaceUserInfo> {
    return realmManager.submit {
      $0.objects(PlaceUserInfo.self)
        .sorted(byKeyPath: "recentDate", ascending: false)
    }
  }

  private func get(by id: Int) -> PlaceUserInfo? {
    return realmManager.submit { $0.object(ofType: PlaceUserInfo.self, forPrimaryKey: id) }
  }
}

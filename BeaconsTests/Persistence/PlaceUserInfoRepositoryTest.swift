//
//  PlaceUserInfoRepositoryTest.swift
//  BeaconsTests
//
//  Created by Антон Назаров on 02/01/2018.
//  Copyright © 2018 com.epam. All rights reserved.
//


import Quick
import Nimble
import RealmSwift
import SwinjectAutoregistration
@testable import Beacons

class PlaceUserInfoRepositoryTest: RealmTest {
  override func spec() {
    super.spec()
    let placeUserInfoRepository = TestUtils.resolver ~> PlaceUserInfoRepository.self

    describe("PlaceUserInfo repository") {
      it("is favourite with not existing always false") {
        expect(placeUserInfoRepository.isFavourite(id: IUP.someId())) == false
      }

      it("is favourite with existing") {
        let somePlaceUserInfo = self.somePlaceUserInfoFromRealm

        expect(placeUserInfoRepository.isFavourite(id: somePlaceUserInfo.id)) == somePlaceUserInfo.isFavourite
      }

      it("toggle favourite with not existing id should create new entity and set it as favourite") {
        let someId = IUP.someId()

        _ = try! placeUserInfoRepository.toggleFavourite(id: someId)

        expect((try! Realm()).object(ofType: PlaceUserInfo.self, forPrimaryKey: someId)).to(satisfies {
          expect($0.id) == someId
          expect($0.isFavourite) == true
        })
      }

      it("toggle favourite with existing id should only toggle favourite flag") {
        let somePlaceUserInfo = self.somePlaceUserInfoFromRealm
        let isFavourite = somePlaceUserInfo.isFavourite

        try! placeUserInfoRepository.toggleFavourite(id: somePlaceUserInfo.id)

        expect((try! Realm()).object(ofType: PlaceUserInfo.self, forPrimaryKey: somePlaceUserInfo.id)!.isFavourite) == !isFavourite
      }

      it("return entities sorted by date") {
        let somePlaceUserInfos = IUC.someArray(IUE.somePlaceUserInfo)

        let realm = try! Realm()
        try! realm.write { realm.add(somePlaceUserInfos) }

        expect(placeUserInfoRepository.getRecent().toArray()).to(contain(exactly: self.sortedByDateDesc(placeUserInfos: somePlaceUserInfos), expect: ==))
      }
    }
  }
}

private extension PlaceUserInfoRepositoryTest {
  func sortedByDateDesc(placeUserInfos: [PlaceUserInfo]) -> [PlaceUserInfo] {
    return placeUserInfos.sorted { $0.recentDate! > $1.recentDate! }
  }
}

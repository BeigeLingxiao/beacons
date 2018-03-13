//
//  PlaceUserInfoTest.swift
//  BeaconsTests
//
//  Created by Антон Назаров on 11.10.2017.
//  Copyright © 2017 com.epam All rights reserved.
//

import Quick
import Nimble
import ObjectMapper
@testable import Beacons

class PlaceUserInfoTest: QuickSpec {
  override func spec() {
    describe("PlaceUserInfo mapper") {
      let places = Mapper<PlaceUserInfo>().mapArray(JSONString: TestUtils.getJSON(name: "placeUserInfo"))!

      it("return all \(PlaceUserInfos.N) test floors") {
        expect(places).to(haveCount(PlaceUserInfos.N))
      }

      it("map first element") {
        expect(places[0]).to(satisfies {
          expect($0.id) == 6_008
          expect($0.descr) == "C & s-eye"
          expect($0.isFavourite).to(beTrue())
        })
      }
    }
  }
}

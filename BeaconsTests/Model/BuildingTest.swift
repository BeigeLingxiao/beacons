//
//  BuildingTest.swift
//  BeaconsTests
//
//  Created by Антон Назаров on 29.09.17.
//  Copyright © 2017 com.epam All rights reserved.
//

import Quick
import Nimble
import ObjectMapper
@testable import Beacons

class BuildingTest: QuickSpec {
  override func spec() {
    describe("Buildings mapper") {
      let buildings = Mapper<Building>().mapArray(JSONString: TestUtils.getJSON(name: "building"))!
      let building = buildings[0]

      it("return all \(Buildings.N) test buildings") {
        expect(buildings).to(haveCount(Buildings.N))
      }

      it("map first element") {
        expect(building).to(satisfies {
          expect($0.id) == 1
          expect($0.name) == "Voonte"
          expect($0.descr) == "Nutritional optic neuropathy"
          expect($0.urlString) == "http://dummyimage.com/204x250.bmp/5fa2dd/ffffff"
          expect($0.latitude) ==~ -91.825_592_517
          expect($0.longitude) ==~ -61.601_735_043
        })
      }

      it("return valid pos property") {
        expect(building.pos).to(satisfies {
          expect($0.latitude) ==~ building.latitude
          expect($0.longitude) ==~ building.longitude
        })
      }

      it("return valid url property") {
        expect(building.url.absoluteString) == building.urlString
      }
    }
  }
}

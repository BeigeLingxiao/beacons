//
//  PlaceTest.swift
//  BeaconsTests
//
//  Created by Антон Назаров on 05.10.2017.
//  Copyright © 2017 com.epam All rights reserved.
//

import Quick
import Nimble
import ObjectMapper
@testable import Beacons

class PlaceTest: QuickSpec {
  override func spec() {
    describe("Place mapper") {
      let places = Mapper<Place>().mapArray(JSONString: TestUtils.getJSON(name: "place"))!
      let place = places[0]

      it("return all \(Places.N) test places") {
        expect(places).to(haveCount(Places.N))
      }

      it("map first element") {
        expect(place).to(satisfies {
          expect($0.latitude) ==~ -72.976_625_49
          expect($0.longitude) ==~ -98.086_219_245
          expect($0.id) == 972
          expect($0.descr) == "Stapedectomy NEC"
          expect($0.type) == "VP Marketing"
        })
      }

      it("should return valid pos property") {
        expect(place.pos).to(satisfies {
          expect($0.latitude) ==~ place.latitude
          expect($0.longitude) ==~ place.longitude
        })
      }
    }
  }
}

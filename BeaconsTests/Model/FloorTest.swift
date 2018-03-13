//
//  FloorTest.swift
//  BeaconsTests
//
//  Created by Антон Назаров on 05.10.2017.
//  Copyright © 2017 com.epam All rights reserved.
//

import Quick
import Nimble
import ObjectMapper
@testable import Beacons

class FloorTest: QuickSpec {
  override func spec() {
    describe("Floor mapper") {
      let floors = Mapper<Floor>().mapArray(JSONString: TestUtils.getJSON(name: "floor"))!
      let floor = floors[0]

      it("should return all \(Floors.N) test floors") {
        expect(floors).to(haveCount(Floors.N))
      }

      it("map first element") {
        expect(floor).to(satisfies {
          expect($0.urlString) == "imagelink"
          expect($0.number) == "8"
          expect($0.width) ≈ (2.324_224_2, 1e-10)
          expect($0.height) ≈ (1.432_423_42, 1e-10)
          expect($0.overlayNorthEastLatitude) ==~ 1.123_123_1
          expect($0.overlayNorthEastLongitude) ==~ 2.123_131_23
          expect($0.overlaySouthWestLatitude) ==~ 4.123_123_12
          expect($0.overlaySouthWestLongitude) ==~  3.123_131_31
          expect($0.beacons).to(haveCount(Floors.BCN_N))
          expect($0.places).to(haveCount(Floors.PLACE_N))
          expect($0.edges).to(haveCount(Floors.EDGE_N))
          expect($0.vertices).to(haveCount(Floors.VERTEX_N))
        })
      }

      it("return valid northEast property") {
        expect(floor.northEast).to(satisfies {
          expect($0.latitude) ==~ floor.overlayNorthEastLatitude
          expect($0.longitude) ==~ floor.overlayNorthEastLongitude
        })
      }

      it("return valid southWest property") {
        expect(floor.southWest).to(satisfies {
          expect($0.latitude) ==~ floor.overlaySouthWestLatitude
          expect($0.longitude) ==~ floor.overlaySouthWestLongitude
        })
      }

      it("return valid url property") {
        expect(floor.url.absoluteString) == floor.urlString
      }
    }
  }
}

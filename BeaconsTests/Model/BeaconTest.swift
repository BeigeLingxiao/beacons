//
//  BeaconTest.swift
//  BeaconsTests
//
//  Created by Антон Назаров on 05.10.2017.
//  Copyright © 2017 com.epam All rights reserved.
//

import Quick
import Nimble
import ObjectMapper
@testable import Beacons

class BeaconTest: QuickSpec {
  override func spec() {
    describe("Beacons mapper") {
      let beacons = Mapper<Beacon>().mapArray(JSONString: TestUtils.getJSON(name: "beacon"))!
      let beacon = beacons[0]

      it("return all \(BeaconsConst.N) test beacons") {
        expect(beacons).to(haveCount(BeaconsConst.N))
      }

      it("map first element") {
        expect(beacon).to(satisfies {
          expect($0.major) == 126
          expect($0.minor) == 620
          expect($0.uuidString) == "250209c9-6a26-4838-91cb-fcb88eae588b"
          expect($0.latitude) ==~ 29.551_065_322
          expect($0.longitude) ==~ 41.084_388_689
        })
      }

      it("should return valid pos property") {
        expect(beacon.pos).to(satisfies {
          expect($0.latitude) ==~ beacon.latitude
          expect($0.longitude) ==~ beacon.longitude
        })
      }

      it("should return valuid uuid property") {
        expect(beacon.uuid.uuidString) == beacon.uuidString.uppercased()
      }
    }
  }
}

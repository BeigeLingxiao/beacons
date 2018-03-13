//
//  TrilaterationTesy.swift
//  BeaconsTests
//
//  Created by Антон Назаров on 14.10.2017.
//  Copyright © 2017 com.epam All rights reserved.
//

import Quick
import Nimble
@testable import Beacons
//swiftlint:disable function_body_length

//https://github.com/lemmingapex/trilateration/blob/master/src/test/java/com/lemmingapex/trilateration
class TrilaterationTest: QuickSpec {
  override func spec() {
    describe("Trilateration test") {
      describe("trilateration2DExact1") {
        it("should be correct") {
          let DELTA = 0.000_1
          let beacons = [
            BeaconDto(accuracy: 1.0, x: 1.0, y: 1.0),
            BeaconDto(accuracy: 1.0, x: 3.0, y: 1.0),
            BeaconDto(accuracy: 1.0, x: 2.0, y: 2.0)
          ]

          expect(NonLinear.determine(IU.toAny(beacons))).to(satisfies {
            expect($0.x).to(beCloseTo(2.0, within: DELTA))
            expect($0.y).to(beCloseTo(1.0, within: DELTA))
          })
        }
      }

      describe("trilateration2DZeroDistance") {
        it("should be correct") {
          let DELTA = 1.1
          let beacons = [
            BeaconDto(accuracy: 0.0, x: 1.0, y: 1.0),
            BeaconDto(accuracy: 1.0, x: 2.0, y: 1.0)
          ]
          expect(NonLinear.determine(IU.toAny(beacons))).to(satisfies {
            expect($0.x).to(beCloseTo(1.0, within: DELTA))
            expect($0.y).to(beCloseTo(1.0, within: DELTA))
          })
        }
      }

      describe("trilateration2DExact2") {
        it("should be correct") {
          let DELTA = 1.3
          let beacons = [
            BeaconDto(accuracy: sqrt(2.0), x: 0.0, y: 0.0),
            BeaconDto(accuracy: 1.0, x: -1.0, y: 0.0),
            BeaconDto(accuracy: 1.0, x: 0.0, y: -1.0)
          ]
          expect(NonLinear.determine(IU.toAny(beacons))).to(satisfies {
            expect($0.x).to(beCloseTo(-1.0, within: DELTA))
            expect($0.y).to(beCloseTo(-1.0, within: DELTA))
          })
        }
      }

      describe("trilateration2DExact3") {
        it("should be correct") {
          let DELTA = 0.000_1
          let beacons = [
            BeaconDto(accuracy: sqrt(2) * 1_000, x: 0.0, y: 0.0),
            BeaconDto(accuracy: 1_000.0, x: 1_000.0, y: 0.0),
            BeaconDto(accuracy: 1_000.0, x: 0.0, y: 1_000.0)
          ]
          expect(NonLinear.determine(IU.toAny(beacons))).to(satisfies {
            expect($0.x).to(beCloseTo(1_000.0, within: DELTA))
            expect($0.y).to(beCloseTo(1_000.0, within: DELTA))
          })
        }
      }

      describe("trilateration2DExact4") {
        it("should be correct") {
          let DELTA = 0.01
          let beacons = [
            BeaconDto(accuracy: 5.0, x: 1.0, y: 1.0),
            BeaconDto(accuracy: 5.0, x: 1.0, y: 3.0),
            BeaconDto(accuracy: 6.36, x: 8.0, y: 8.0),
            BeaconDto(accuracy: 3.9, x: 2.0, y: 2.0)
          ]
          expect(NonLinear.determine(IU.toAny(beacons))).to(satisfies {
            expect($0.x).to(beCloseTo(5.9, within: DELTA))
            expect($0.y).to(beCloseTo(2.0, within: DELTA))
          })
        }
      }

      describe("trilateration2DExact5") {
        it("should be correct") {
          let DELTA = 0.01
          let beacons = [
            BeaconDto(accuracy: 8.06, x: 5.0, y: -6.0),
            BeaconDto(accuracy: 13.97, x: 13.0, y: -15.0),
            BeaconDto(accuracy: 23.32, x: 21.0, y: -3.0)
          ]
          expect(NonLinear.determine(IU.toAny(beacons))).to(satisfies {
            expect($0.x).to(beCloseTo(-0.6, within: DELTA))
            expect($0.y).to(beCloseTo(-11.8, within: DELTA))
          })
        }
      }

      describe("trilateration2DInexact1") {
        it("should be correct") {
          let DELTA = 0.1
          let beacons = [
            BeaconDto(accuracy: 0.9, x: 1.0, y: 1.0),
            BeaconDto(accuracy: 1.0, x: 3.0, y: 1.0),
            BeaconDto(accuracy: 1.0, x: 2.0, y: 2.0)
          ]
          expect(NonLinear.determine(IU.toAny(beacons))).to(satisfies {
            expect($0.x).to(beCloseTo(2.0, within: DELTA))
            expect($0.y).to(beCloseTo(1.0, within: DELTA))
          })
        }
      }

      describe("trilateration2DInexact2") {
        it("should be correct") {
          let DELTA = 0.4
          let beacons = [
            BeaconDto(accuracy: 8.06, x: 5.0, y: -6.0),
            BeaconDto(accuracy: 13.97, x: 13.0, y: -15.0),
            BeaconDto(accuracy: 23.32, x: 21.0, y: -3.0),
            BeaconDto(accuracy: 15.31, x: 12.42, y: -21.2)
          ]
          expect(NonLinear.determine(IU.toAny(beacons))).to(satisfies {
            expect($0.x).to(beCloseTo(-0.6, within: DELTA))
            expect($0.y).to(beCloseTo(-11.8, within: DELTA))
          })
        }
      }

      describe("trilateration2DNonIntersecting") {
        it("should be correct") {
          let DELTA = 0.25
          let beacons = [
            BeaconDto(accuracy: 0.5, x: 1.0, y: 1.0),
            BeaconDto(accuracy: 0.5, x: 3.0, y: 1.0),
            BeaconDto(accuracy: 0.5, x: 2.0, y: 2.0)
          ]
          expect(NonLinear.determine(IU.toAny(beacons))).to(satisfies {
            expect($0.x).to(beCloseTo(2.0, within: DELTA))
            expect($0.y).to(beCloseTo(1.0, within: DELTA))
          })
        }
      }

      describe("trilateration2DOverIntersecting") {
        it("should be correct") {
          let DELTA = 1.5
          let beacons = [
            BeaconDto(accuracy: 2.0, x: 1.0, y: 1.0),
            BeaconDto(accuracy: 2.0, x: 3.0, y: 1.0),
            BeaconDto(accuracy: 2.0, x: 2.0, y: 2.0)
          ]
          expect(NonLinear.determine(IU.toAny(beacons))).to(satisfies {
            expect($0.x).to(beCloseTo(2.0, within: DELTA))
            expect($0.y).to(beCloseTo(1.0, within: DELTA))
          })
        }
      }

      describe("trilateration2DDegenerateCase1") {
        it("should be correct") {
          let DELTA = 1.5
          let beacons = [
            BeaconDto(accuracy: 1.0, x: 1.0, y: 1.0),
            BeaconDto(accuracy: 1.0, x: 1.0, y: 1.0),
            BeaconDto(accuracy: 1.0, x: 1.0, y: 3.0)
          ]
          expect(NonLinear.determine(IU.toAny(beacons))).to(satisfies {
            expect($0.x).to(beCloseTo(2.0, within: DELTA))
            expect($0.y).to(beCloseTo(1.0, within: DELTA))
          })
        }
      }

      describe("trilateration2DDegenerateCase2") {
        it("should be correct") {
          let DELTA = 1.0
          let beacons = [
            BeaconDto(accuracy: 1.0, x: 1.0, y: 1.0),
            BeaconDto(accuracy: 1.0, x: 1.0, y: 1.0),
            BeaconDto(accuracy: 1.0, x: 1.0, y: 1.0)
          ]
          expect(NonLinear.determine(IU.toAny(beacons))).to(satisfies {
            expect($0.x).to(beCloseTo(1.0, within: DELTA))
            expect($0.y).to(beCloseTo(1.0, within: DELTA))
          })
        }
      }

      describe("trilateration2DUnderdertermined") {
        it("should be correct") {
          let DELTA = 0.5
          let beacons = [
            BeaconDto(accuracy: 1.0, x: 1.0, y: 1.0),
            BeaconDto(accuracy: 1.0, x: 3.0, y: 1.0)
          ]
          expect(NonLinear.determine(IU.toAny(beacons))).to(satisfies {
            expect($0.x).to(beCloseTo(2.0, within: DELTA))
            expect($0.y).to(beCloseTo(1.0, within: DELTA))
          })
        }
      }
    }
  }
}

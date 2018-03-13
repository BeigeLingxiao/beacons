//
//  File.swift
//  BeaconsTests
//
//  Created by Антон Назаров on 05.10.2017.
//  Copyright © 2017 com.epam All rights reserved.
//

import Quick
import Nimble
import ObjectMapper
@testable import Beacons

class EdgeTest: QuickSpec {
  override func spec() {
    describe("Edge mapper") {
      let edges = Mapper<Edge>().mapArray(JSONString: TestUtils.getJSON(name: "edge"))!

      it("return all \(Edges.N) test edges") {
        expect(edges).to(haveCount(Edges.N))
      }

      it("map first element") {
        expect(edges[0]).to(satisfies {
          expect($0.weight) ≈ (60.743_97, 1e-4)
          expect($0.v1) == 19
          expect($0.v2) == 84
        })
      }
    }
  }
}

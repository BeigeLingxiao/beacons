//
//  VertexTest.swift
//  BeaconsTests
//
//  Created by Антон Назаров on 05.10.2017.
//  Copyright © 2017 com.epam All rights reserved.
//

import Quick
import Nimble
import ObjectMapper
@testable import Beacons

class VertexTest: QuickSpec {
  override func spec() {
    describe("Vertex mapper") {
      let vertices = Mapper<Vertex>().mapArray(JSONString: TestUtils.getJSON(name: "vertex"))!
      let vertex = vertices[0]

      it("return all \(Vertices.N) test vertexes") {
        expect(vertices).to(haveCount(Vertices.N))
      }

      it("map first element") {
        expect(vertex).to(satisfies {
          expect($0.latitude) ==~ 91.370_353_214
          expect($0.longitude) ==~ -12.798_433
          expect($0.id) == 1
        })
      }

      it("return valid pos property") {
        expect(vertex.pos).to(satisfies {
          expect($0.latitude) ==~ vertex.latitude
          expect($0.longitude) ==~ vertex.longitude
        })
      }
    }
  }
}

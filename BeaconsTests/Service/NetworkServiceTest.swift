//
//  NetworkServiceTest.swift
//  BeaconsTests
//
//  Created by Антон Назаров on 09.11.2017.
//  Copyright © 2017 com.epam All rights reserved.
//

import Quick
import Nimble
import OHHTTPStubs
import Alamofire
import RxSwift
import RxBlocking
import SwinjectAutoregistration
@testable import Beacons

class NetworkServiceTest: QuickSpec {
  override func spec() {
    let networkService = NetworkServiceImpl(sessionManager: TestUtils.resolver ~> SessionManager.self)

    describe("Network service test") {
      afterEach {
        OHHTTPStubs.removeAllStubs()
      }

      it("validate status code") {
        stub(condition: AnyUrl) { _ in
          return fixture(filePath: OHPathForFile("building.json", type(of: self))!, status: Int32(IUP.someInt()), headers: ["Content-Type":"application/json"])
        }

        expect { try networkService.getBuildings().toBlocking().single() }.to(throwError())
      }

      it("validate headers") {
        stub(condition: AnyUrl) { _ in
          return fixture(filePath: OHPathForFile("building.json", type(of: self))!, status: 200, headers: nil)
        }

        expect { try networkService.getBuildings().toBlocking().single() }.to(throwError())
      }

      it("return buildings") {
        stub(condition: AnyUrl) { _ in
          return fixture(filePath: OHPathForFile("building.json", type(of: self))!, status: 200, headers: ["Content-Type":"application/json"])
        }

        expect(try! networkService.getBuildings().toBlocking().single().count) == Buildings.N
      }
    }
  }
}


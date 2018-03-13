//
//  CuckooTest.swift
//  BeaconsTests
//
//  Created by Антон Назаров on 14/12/2017.
//  Copyright © 2017 com.epam. All rights reserved.
//

import Quick
import Nimble
import RealmSwift
import Cuckoo
import SwinjectAutoregistration
@testable import Beacons

class CuckooTest: QuickSpec {
  private var cleaningWork = [() -> Void]()

  func register<M: Mock>(mock: M) {
    cleaningWork.append({ reset(mock) })
  }

  override func spec() {
    afterEach {
      self.cleaningWork.forEach { $0() }
    }
  }
}

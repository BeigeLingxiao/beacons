//
//  BeCloseToCoordinate.swift
//  BeaconsTests
//
//  Created by Антон Назаров on 29/11/2017.
//  Copyright © 2017 com.epam All rights reserved.
//

import Nimble
@testable import Beacons

infix operator ==~: ComparisonPrecedence

func ==~ (lhs: Nimble.Expectation<Double>, rhs: Double) {
  lhs.to(beCloseToCoord(rhs))
}

public func beCloseToCoord(_ expectedValue: Double) -> Predicate<Double> {
  return beCloseTo(expectedValue, within: CoordinateConstant.delta)
}

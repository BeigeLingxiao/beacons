//
//  Satisfies.swift
//  BeaconsTests
//
//  Created by Антон Назаров on 29/11/2017.
//  Copyright © 2017 com.epam All rights reserved.
//

import Nimble

func satisfies<T>(_ expectations: @escaping (_ resultValue: T) throws -> Void) -> Predicate<T> {
  return Predicate {
    guard let actualValue = try $0.evaluate() else {
      return PredicateResult(
        status: .fail,
        message: .fail("evaluation of actual value failed")
      )
    }
    do {
      try expectations(actualValue)
      return PredicateResult(status: .matches, message: .expectedActualValueTo("match all expectations"))
    } catch let err {
      return PredicateResult(
        status: .fail,
        message: ExpectationMessage.fail(err.localizedDescription)
      )
    }
  }
}

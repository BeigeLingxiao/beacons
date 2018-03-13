//
//  ContainsExactly.swift
//  BeaconsTests
//
//  Created by Антон Назаров on 29/11/2017.
//  Copyright © 2017 com.epam All rights reserved.
//

import Nimble
import RealmSwift

func contain<T>(exactly expected: [T], expect expectations: @escaping (T, T) -> Void) -> Predicate<[T]> {
  return Predicate {
    guard let actual = try $0.evaluate() else {
      return PredicateResult(
        status: .fail,
        message: .fail("evaluation of actual value failed")
      )
    }
    return actual.elementsEqual(expected) { expectations($0, $1); return true } ?
      PredicateResult(status: .matches, message: .expectedActualValueTo("exactly contain")) :
      PredicateResult(status: .fail, message: ExpectationMessage.fail("not equal"))
  }
}

func contain<T>(exactly expected: List<T>, expect expectations: @escaping (T, T) -> Void) -> Predicate<List<T>> {
  return Predicate {
    guard let actual = try $0.evaluate() else {
      return PredicateResult(
        status: .fail,
        message: .fail("evaluation of actual value failed")
      )
    }
    return actual.elementsEqual(expected) { expectations($0, $1); return true } ?
      PredicateResult(status: .matches, message: .expectedActualValueTo("exactly contain")) :
      PredicateResult(status: .fail, message: ExpectationMessage.fail("not equal"))
  }
}

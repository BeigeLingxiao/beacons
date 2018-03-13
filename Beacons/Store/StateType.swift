//
//  StateType.swift
//  Beacons
//
//  Created by Антон Назаров on 21/12/2017.
//  Copyright © 2017 com.epam. All rights reserved.
//

enum StateType<T: Equatable> {
  case choosen(T)
  case notChoosen

  init(_ value: T) {
    self = .choosen(value)
  }

  func orElse(_ defaultValue: T) -> T {
    guard case let .choosen(value) = self else {
      return defaultValue
    }
    return value
  }
}

// MARK: - Equatable
extension StateType: Equatable {
  static func == (lhs: StateType<T>, rhs: StateType<T>) -> Bool {
    switch (lhs, rhs) {
    case let (.choosen(lhsValue), .choosen(rhsValue)):
      return lhsValue == rhsValue
    case (.notChoosen, .notChoosen):
      return true
    default:
      return false
    }
  }
}

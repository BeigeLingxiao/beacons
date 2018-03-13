//
//  Store.swift
//  Beacons
//
//  Created by Антон Назаров on 07/12/2017.
//  Copyright © 2017 com.epam. All rights reserved.
//

import RxSwift

class Store {
  private let state: State
  private let _networkError = ReplaySubject<String>.create(bufferSize: 1)
  private let _businessError = ReplaySubject<String>.create(bufferSize: 1)

  let networkError: Observable<String>
  let businessError: Observable<String>

  init(state: State) {
    self.state = state
    networkError = _networkError.asObservable().logged(identifier: "Network error")
    businessError = _businessError.asObserver().logged(identifier: "Business error")
  }

  func dispatch(_ action: Action) {
    switch action {
    case .networkError(let error):
      _networkError.onNext(error.rawValue)
    case .businessError(let error):
      _businessError.onNext(error.rawValue)
    default:
      state.dispatch(action)
    }
  }
}

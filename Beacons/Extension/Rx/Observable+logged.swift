//
//  Observable+logged.swift
//  Beacons
//
//  Created by Антон Назаров on 19/12/2017.
//  Copyright © 2017 com.epam All rights reserved.
//

import RxSwift

extension ObservableType {
  func logged(identifier: String) -> Observable<E> {
    return Observable.create { observer in
      log.verbose("subscribed \(identifier)")
      let subscription = self.subscribe { event in
        switch event {
        case .next(let value):
          observer.on(.next(value))
          log.verbose("event \(identifier) \(event)")
        case .error(let error):
          observer.on(.error(error))
          log.error("event \(identifier) \(event)")
        case .completed:
          observer.on(.completed)
          log.verbose("event \(identifier) \(event)")
        }
      }
      return Disposables.create {
        log.verbose("disposing \(identifier)")
        subscription.dispose()
      }
    }
  }
}

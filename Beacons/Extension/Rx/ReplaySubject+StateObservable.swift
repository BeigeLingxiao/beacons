//
//  StateObservable.swift
//  Beacons
//
//  Created by Антон Назаров on 16/12/2017.
//  Copyright © 2017 com.epam All rights reserved.
//

import RxSwift

/// All states should skip initial value, be distinct and be shared and be logged
extension ReplaySubject where Element: Equatable {
  func asState(identifier: String) -> Observable<E> {
    return self.asObservable()
      .distinctUntilChanged()
      .share(replay: 1)
      .logged(identifier: identifier)
  }
}

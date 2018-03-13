//
//  Observable+voidly.swift
//  Beacons
//
//  Created by Антон Назаров on 19/12/2017.
//  Copyright © 2017 com.epam All rights reserved.
//

import RxSwift

extension ObservableType {
  func voidly() -> Observable<Void> {
    return self.map { _ in Void() }
  }
}

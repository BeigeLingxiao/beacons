//
//  Identifiable.swift
//  Beacons
//
//  Created by Антон Назаров on 06/12/2017.
//  Copyright © 2017 com.epam All rights reserved.
//

import UIKit

protocol Identifiable {
  static var identifier: String { get }
}

extension Identifiable {
  static var identifier: String {
    return String(describing: self)
  }
}

//
//  NibLoadable.swift
//  Beacons
//
//  Created by Антон Назаров on 06/12/2017.
//  Copyright © 2017 com.epam. All rights reserved.
//

protocol NibLoadable {
  static var nibName: String { get }
}

extension NibLoadable {
  static var nibName: String {
    return String(describing: self)
  }
}

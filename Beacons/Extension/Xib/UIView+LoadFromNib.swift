//
//  UIView+LoadFromNib.swift
//  Beacons
//
//  Created by Антон Назаров on 06/12/2017.
//  Copyright © 2017 com.epam. All rights reserved.
//

extension UIView: NibLoadable {
  static func nib(_ bundle: Bundle? = nil) -> UINib {
    return UINib(nibName: nibName, bundle: bundle)
  }

  static func loadFromNib<T: NibLoadable>(ofType _: T.Type) -> T {
    guard let nibViews = Bundle.main.loadNibNamed(T.nibName, owner: nil, options: nil) else {
      fatalError("Could not instantiate view from nib file")
    }

    if let typedView = nibViews.first as? T {
      return typedView
    }

    fatalError("Could not instantiate view from nib file")
  }
}

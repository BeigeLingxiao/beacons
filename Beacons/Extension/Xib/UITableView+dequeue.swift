//
//  UITableView+dequeue.swift
//  Beacons
//
//  Created by Антон Назаров on 25/12/2017.
//  Copyright © 2017 com.epam. All rights reserved.
//

extension UITableView {
  func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T {
    guard let cell = dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as? T else {
      fatalError("Could not dequeue cell with identifier: \(T.identifier)")
    }
    return cell
  }
}

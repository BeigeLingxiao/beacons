//
//  UITableView+Register.swift
//  Beacons
//
//  Created by Антон Назаров on 06/12/2017.
//  Copyright © 2017 com.epam. All rights reserved.
//

extension UITableView {
  func register(_ cell: UITableViewCell.Type) {
    register(cell.nib(), forCellReuseIdentifier: cell.identifier)
  }
}

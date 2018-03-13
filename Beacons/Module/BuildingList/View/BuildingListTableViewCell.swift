//
//  BuildingListTableViewCell.swift
//  Beacons
//
//  Created by Антон Назаров on 28.10.2017.
//  Copyright © 2017 com.epam All rights reserved.
//

import RxSwift

class BuildingListTableViewCell: UITableViewCell {
  //swiftlint:disable private_outlet
  @IBOutlet weak var descr: UILabel!
  @IBOutlet weak var name: UILabel!
  @IBOutlet weak var icon: UIImageView!
  //swiftlint:enable private_outlet
}

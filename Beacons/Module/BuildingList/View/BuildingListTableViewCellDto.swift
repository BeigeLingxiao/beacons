//
//  BuildingListTableViewCellDto.swift
//  Beacons
//
//  Created by Антон Назаров on 12.10.2017.
//  Copyright © 2017 com.epam All rights reserved.
//

import UIKit
import Kingfisher

struct BuildingListTableViewCellDto {
  private let title: String
  private let subtitle: String
  private let loadingPlaceholder = IndicatorType.image(imageData: Utils.getGif(name: "loading"))
  private let iconUrl: URL
  let id: Int

  init(title: String, subtitle: String, id: Int, iconUrl: URL) {
    self.title = title
    self.subtitle = subtitle
    self.id = id
    self.iconUrl = iconUrl
  }

  func configureCell(_ cell: BuildingListTableViewCell) {
    cell.name.text = title
    cell.descr.text = subtitle
    cell.icon.do {
      $0.kf.indicatorType = loadingPlaceholder
      $0.kf.setImage(with: iconUrl)
    }
  }
}

//
//  PlaceSearchTableViewCellDto.swift
//  Beacons
//
//  Created by Антон Назаров on 25/12/2017.
//  Copyright © 2017 com.epam. All rights reserved.
//

import RxDataSources

struct PlaceSearchTableViewCellDto {
  let type: PlaceType
  let title: String
  let subtitle: String
  let id: Int

  init(type: PlaceType, title: String, subtitle: String, id: Int) {
    self.type = type
    self.title = title
    self.subtitle = subtitle
    self.id = id
  }

  func configureCell(_ cell: PlaceSearchTableViewCell) {
    cell.textLabel?.text = title
    cell.detailTextLabel?.text = subtitle
    switch type {
    case .favourite:
      cell.imageView?.image = #imageLiteral(resourceName: "ic_star_border")
    case .recent:
      cell.imageView?.image = #imageLiteral(resourceName: "ic_history")
    default:
      break
    }
  }
}

// MARK: - IdentifiableType
extension PlaceSearchTableViewCellDto: IdentifiableType {
  typealias Identity = Int

  var identity: Int {
    return id
  }
}

// MARK: - Equatable
extension PlaceSearchTableViewCellDto: Equatable {
  static func == (lhs: PlaceSearchTableViewCellDto, rhs: PlaceSearchTableViewCellDto) -> Bool {
    return lhs.id == rhs.id
  }
}

//
//  PlaceSearchSection.swift
//  Beacons
//
//  Created by Антон Назаров on 25/12/2017.
//  Copyright © 2017 com.epam. All rights reserved.
//

import RxDataSources

struct PlaceSearchSection {
  var header: String

  var items: [Item]
}

// MARK: - SectionModelType
extension PlaceSearchSection: SectionModelType {
  typealias Item = PlaceSearchTableViewCellDto

  init(original: PlaceSearchSection, items: [Item]) {
    self = original
    self.items = items
  }
}

// MARK: - AnimatableSectionModelType
extension PlaceSearchSection: AnimatableSectionModelType {
  typealias Identity = String

  var identity: String {
    return header
  }
}

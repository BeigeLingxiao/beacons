//
//  PlaceSearchViewController.swift
//  Beacons
//
//  Created by Антон Назаров on 12.10.2017.
//  Copyright © 2017 com.epam All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

final class PlaceSearchViewController: UIViewController {
  @IBOutlet weak private var tableView: UITableView!
  @IBOutlet weak private var searchBar: UISearchBar!
  @IBOutlet weak private var cancel: UIButton!
  private let disposeBag = DisposeBag()
  var placeSearchPresenter: PlaceSearchPresentation!

  override func viewDidLoad() {
    super.viewDidLoad()
    subscriptNavigation()
    configureTableDataSource()
  }
}

// MARK: - Datasource
private extension PlaceSearchViewController {
  func configureTableDataSource() {
    tableView.register(PlaceSearchTableViewCell.self)
    let datasource = RxTableViewSectionedAnimatedDataSource<PlaceSearchSection>(
      configureCell: { datastore, tableView, indexPath, item in
        let cell: PlaceSearchTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        item.configureCell(cell)
        return cell
    },
      titleForHeaderInSection: { datastore, index in
        return datastore[index].header
    })

    placeSearchPresenter.search(
      query: searchBar.rx.text.orEmpty
        .asDriver()
        .throttle(0.3)
        .distinctUntilChanged()
      ).drive(tableView.rx.items(dataSource: datasource))
      .disposed(by: disposeBag)

    tableView.rx.modelSelected(PlaceSearchTableViewCellDto.self)
      .subscribe(onNext: { [unowned self] in
        self.placeSearchPresenter.choose(place: $0)
        self.dismiss(animated: false)
      }).disposed(by: disposeBag)
  }
}

// MARK: - Subscribt buttons
private extension PlaceSearchViewController {
  func subscriptNavigation() {
    cancel.rx.tap.subscribe(onNext: { [unowned self] in
      self.dismiss(animated: false)
    }).disposed(by: disposeBag)
  }
}

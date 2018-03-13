//
//  BuildingListViewController.swift
//  Beacons
//
//  Created by Антон Назаров on 23.10.2017.
//  Copyright © 2017 com.epam All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class BuildingListViewController: UIViewController {
  @IBOutlet weak private var tableView: UITableView!
  private let disposeBag = DisposeBag()
  var buildingListPresenter: BuildingListPresentation!
  var roomMapWireframe: RoomMapWireframe!

  override func viewDidLoad() {
    super.viewDidLoad()

    configureTableView()
    configureNavigationBar()
    configureDataSource()
    tableView.reloadData()
    configureRefreshControl()
  }
}

// MARK: - Style
private extension BuildingListViewController {
  func configureTableView() {
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.register(BuildingListTableViewCell.self)
  }

  func configureNavigationBar() {
    navigationController?.navigationBar.topItem?.titleView = UIImageView().then {
      $0.image = #imageLiteral(resourceName: "ic_epam")
      $0.contentMode = .scaleAspectFit
    }
    navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
  }
}

// MARK: - Datasource
private extension BuildingListViewController {
  func configureDataSource() {
    buildingListPresenter.buildings
      .bind(to: tableView.rx.items(
        cellIdentifier: BuildingListTableViewCell.identifier,
        cellType: BuildingListTableViewCell.self)
      ) { _, building, cell in
        building.configureCell(cell)
      }.disposed(by: disposeBag)

    tableView.rx.modelSelected(BuildingListTableViewCellDto.self)
      .map { $0.id }
      .map(Action.enterBuilding)
      .do(onNext: store.dispatch)
      .subscribe(onNext: { [unowned self] _ in
        self.roomMapWireframe.navigate(in: self.navigationController)
      }).disposed(by: disposeBag)
  }
}

// MARK: - Refresh control
private extension BuildingListViewController {
  func configureRefreshControl() {
    tableView.refreshControl = UIRefreshControl()
    tableView.refreshControl?.rx.controlEvent(.valueChanged).subscribe(onNext: { [unowned self] in
      self.buildingListPresenter.reloadBuildings()
    }).disposed(by: disposeBag)

    buildingListPresenter.buildings.subscribe(onNext: { [unowned self] _ in
      self.tableView.refreshControl?.endRefreshing()
    }).disposed(by: disposeBag)

    store.networkError.map {
      UIAlertController(title: "Error", message: $0, preferredStyle: .alert).then {
        $0.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
      }
    }.subscribe(onNext: { [unowned self] in
      self.present($0, animated: true, completion: self.tableView.refreshControl?.endRefreshing)
    }).disposed(by: disposeBag)
  }
}

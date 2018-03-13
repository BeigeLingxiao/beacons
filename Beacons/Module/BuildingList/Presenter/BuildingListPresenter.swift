//
//  BuildingListPresenter.swift
//  Beacons
//
//  Created by Антон Назаров on 23.10.2017.
//  Copyright © 2017 com.epam All rights reserved.
//

import RxSwift
import RxRealm
import RxCocoa
import RealmSwift

class BuildingListPresenter: BuildingListPresentation {
  private let buildingService: BuildingService
  private let networkService: NetworkService
  private let syncInfoService: SyncInfoService
  private let disposeBag = DisposeBag()
  var buildings: Observable<[BuildingListTableViewCellDto]>

  init(buildingService: BuildingService, networkService: NetworkService, syncInfoService: SyncInfoService) {
    self.buildingService = buildingService
    self.networkService = networkService
    self.syncInfoService = syncInfoService
    buildings = buildingService.getAll()
      .map { $0.toAnyCollection() }
      .map { $0.map { BuildingListTableViewCellDto(title: $0.name, subtitle: $0.descr, id: $0.id, iconUrl: $0.url) } }

    syncInfoService.isListSyncNeeded()
      .subscribe(onNext: { [unowned self] in _ = self.reloadBuildings() })
      .disposed(by: disposeBag)
  }

  func reloadBuildings() {
    networkService.getBuildings()
      .subscribe(
        onSuccess: { [unowned self] in
          _ = self.buildingService.replaceAll($0)
          _ = self.syncInfoService.add()
        },
        onError: {
          guard let networkError = $0 as? NetworkError else {
            fatalError("Not excpected error")
          }
          store.dispatch(.networkError(networkError))
      }).disposed(by: disposeBag)
  }
}

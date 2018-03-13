//
//  RoomMapPresenter.swift
//  Beacons
//
//  Created by Антон Назаров on 15.10.2017.
//  Copyright © 2017 com.epam All rights reserved.
//

import RxSwift
import RxCocoa
import RxSwiftExt
import Kingfisher

class RoomMapPresenter: RoomMapPresentation {
  private let disposeBag = DisposeBag()
  private let state: State
  private let placeService: PlaceService
  private let placeUserInfoService: PlaceUserInfoService

  var currentPath: Driver<GMSPath>
  var currentOverlay: Driver<GMSGroundOverlay>
  var enteredBuilding: Observable<Building>
  var enteredFloor: Driver<String>

  init(findWayInteractor: FindWayInteractor,
       buildingService: BuildingService,
       networkService: NetworkService,
       floorService: FloorService,
       syncInfoService: SyncInfoService,
       placeUserInfoService: PlaceUserInfoService,
       positionInteractor: PositionInteractor,
       placeService: PlaceService,
       state: State
    ) {
    self.state = state
    self.placeService = placeService
    self.placeUserInfoService = placeUserInfoService

    state.enteredBuildingId
      .flatMap(syncInfoService.isBuildingSyncNeeded)
      .withLatestFrom(state.enteredBuildingId)
      .flatMap { id in
        networkService.getFloors(ofBuilding: id)
          .map { (id: id, floors: $0) }
      }
      .subscribe(
        onNext: {
          _ = syncInfoService.add($0.id)
          _ = floorService.replace(floors: $0.floors, inBuilding: $0.id)
      },
        onError: {
          guard let networkError = $0 as? NetworkError else {
            fatalError("Not expected error")
          }
          store.dispatch(.networkError(networkError))
      }
      ).disposed(by: disposeBag)

    enteredBuilding = state.enteredBuildingId.flatMap(buildingService.get).share(replay: 1)

    enteredBuilding.map {
      guard let floor = $0.floors.first?.number else {
        return Action.businessError(BusinessError.noFloors)
      }
      return Action.enterFloor(number: floor)
    }
    .subscribe(onNext: store.dispatch)
    .disposed(by: disposeBag)

    enteredFloor = state.enteredFloor
      .asDriver(onErrorDriveWith: .never())

    currentOverlay = Observable.combineLatest(enteredBuilding, state.enteredFloor)
      .map {
        let (building, floorNumber) = $0
        guard let floor = building.floors.first(where: { $0.number == floorNumber }) else {
          log.error("No floor")
          throw BusinessError.noFloors
        }
        return floor
      }
      .map(RoomMapPresenter.getOverlay)
      .asDriver(onErrorJustReturn: GMSGroundOverlay())

    currentPath = findWayInteractor.path
      .asDriver(onErrorDriveWith: .never())
  }

  func addToFavourite(click: Observable<()>) -> Disposable {
    return click
      .withLatestFrom(state.choosenPlaceId)
      .subscribe(onNext: {
        self.placeUserInfoService.toggleFavourite(id: $0.orElse(-1))
      })
  }
}

// MARK: - Overlay
private extension RoomMapPresenter {
  static func getOverlay(forFloor floor: Floor) -> GMSGroundOverlay {
    let overlay = GMSGroundOverlay(
      bounds: GMSCoordinateBounds(coordinate: floor.northEast, coordinate: floor.southWest),
      icon: nil
    )

    let url = floor.url
    #if MOCK
      overlay.icon = #imageLiteral(resourceName: "0")
    #else
      KingfisherManager.shared.retrieveImage(
        with: url, options: nil, progressBlock: nil, completionHandler: { (image, _, _, _) in
          overlay.icon = image
      })
    #endif
    return overlay
  }
}

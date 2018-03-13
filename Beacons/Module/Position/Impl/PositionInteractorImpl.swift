//
//  PositionInteractorImpl.swift
//  Beacons
//
//  Created by Антон Назаров on 15.10.2017.
//  Copyright © 2017 com.epam All rights reserved.
//

import RxSwift
import RxCocoa

class PositionInteractorImpl: PositionInteractor {
  private let beaconService: BeaconService
  private let positionHandlingInteractor: PositionHandlingInteractor
  private var currentBeacons = [NSNumber: Beacon]()
  private var currentBeaconDtos = [NSNumber: BeaconDto]()
  private let disposeBag = DisposeBag()

  var locationManager =  CLLocationManager()
  var position: Driver<CLLocationCoordinate2D>!
  var beacons: Driver<[GMSCircle]>!

  init(beaconService: BeaconService, positionHandlingInteractor: PositionHandlingInteractor, state: State) {

    self.beaconService = beaconService
    self.positionHandlingInteractor = positionHandlingInteractor

    let filteredBeaconDtos = locationManager.rx.didRangeBeaconsInRegion
      .map { $0.beacons.filter { $0.rssi > -95 && $0.rssi <  -50 } }
      .do(onNext: { [unowned self] clbeacons in
        clbeacons.forEach {
            self.currentBeaconDtos[$0.minor]?.accuracy = $0.accuracy
        }
      })
      .map { [unowned self] in $0.flatMap { self.currentBeaconDtos[$0.minor] } }
      .share(replay: 1)

    position = filteredBeaconDtos
      .map(positionHandlingInteractor.handle)
      .asDriver(onErrorJustReturn: kCLLocationCoordinate2DInvalid)

    beacons = filteredBeaconDtos
      .map { $0.map { GMSCircle(position: GMSUnproject(GMSMapPoint(x: $0.x, y: $0.y)), radius: $0.accuracy) } }
      .asDriver(onErrorJustReturn: [GMSCircle]())

    Observable.combineLatest(state.enteredBuildingId, state.enteredFloor)
      .subscribe(onNext: { [unowned self] in
        self.replaceScanningRegion(building: $0.0, floor: $0.1)
      }).disposed(by: disposeBag)

    position.drive(onNext: {
      state.dispatch(.moveTo(pos: $0))
    }).disposed(by: disposeBag)
  }

  private func isLocationManagerEnable(status: CLAuthorizationStatus) -> Bool {
    return status == .authorizedAlways
      && CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self)
      && CLLocationManager.isRangingAvailable()
  }

  func replaceScanningRegion(building: Int, floor: String) {
    currentBeacons.removeAll()
    currentBeaconDtos.removeAll()
    beaconService.getAll(fromBuilding: building, floor: floor).forEach {
      self.currentBeacons[NSNumber(value: $0.minor)] = $0
      let point = GMSProject($0.pos)
      self.currentBeaconDtos[NSNumber(value: $0.minor)] = BeaconDto(accuracy: 0.1, x: point.x, y: point.y)
    }

    locationManager.rangedRegions.forEach(locationManager.stopMonitoring)

    for element in currentBeacons {
        locationManager.startRangingBeacons(in: CLBeaconRegion(proximityUUID: element.value.uuid, identifier: "beacons"))
    }
  }
}

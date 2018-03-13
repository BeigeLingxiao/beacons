//
//  MapViewController.swift
//  Beacons
//
//  Created by Антон Назаров on 29.10.2017.
//  Copyright © 2017 com.epam All rights reserved.
//

import GoogleMaps
import RxSwift
import RxCocoa

final class MapViewController: UIViewController {
  @IBOutlet weak private var mapView: GMSMapView!
  private let marker = GMSMarker()
  private let disposeBag = DisposeBag()
  var mapPresenter: MapPresentation!
  var roomMapWireframe: RoomMapWireframe!

  override func viewDidLoad() {
    super.viewDidLoad()
    self.marker.map = self.mapView
    subscriptOnPresenter()
  }
}

// MARK: - Subscribt presenter
private extension MapViewController {
  func subscriptOnPresenter() {
    mapPresenter.markerPos.drive(onNext: { [unowned self] in
      self.marker.position = $0
      self.mapView.animate(toLocation: $0)
    }).disposed(by: disposeBag)
  }
}

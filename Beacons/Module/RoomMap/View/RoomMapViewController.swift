//
//  RoomMapViewController.swift
//  Beacons
//
//  Created by Антон Назаров on 26.09.17.
//  Copyright © 2017 com.epam All rights reserved.
//

import UIKit
import SwiftyPickerPopover
import RxSwift
import RxCocoa

final class RoomMapViewController: UIViewController {
  @IBOutlet private weak var mapView: GMSMapView!
  @IBOutlet weak private var positionButton: UIBarButtonItem!
  @IBOutlet weak private var sendLogs: UIBarButtonItem!
  @IBOutlet weak private var favourite: UIBarButtonItem!
  private var beacons = [GMSCircle]()
  private let line = GMSPolyline()
  private var position: GMSMarker!
  private let disposeBag = DisposeBag()
  var positionInteractor: PositionInteractor!
  var roomMapPresenter: RoomMapPresentation!
  var searchWireframe: PlaceSearchWireframe!

  override func viewDidLoad() {
    super.viewDidLoad()
    positionInteractor.locationManager.requestAlwaysAuthorization()

    configureNavigationItem()

    configureMap()
    configurePathLine()
    configurePositionMarker()

    subscriptOverlay()
    subscriptPath()
    subscribtError()

    subscriptOnVisualization()
    subscriptPosition()

    subscriptOnButtons()

    handleBusinessError()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    (navigationItem.titleView as? UISearchBar)?.endEditing(true)
  }
}

// MARK: - Navigation bar
private extension RoomMapViewController {
  func configureNavigationItem() {
    navigationItem.rightBarButtonItem = UIBarButtonItem(customView: UIButton(type: .system).then { button in
      //TODO default state?
      button.setTitle(" ", for: .normal)
      self.roomMapPresenter.enteredFloor.drive(onNext: {
        button.setTitle($0, for: .normal)
      }).disposed(by: disposeBag)

      button.rx.tap.withLatestFrom(roomMapPresenter.enteredBuilding)
        .subscribe(onNext: { [unowned self] building in
          StringPickerPopover(title: "", choices: building.floors.map { $0.number })
            .setDoneButton { (_, _, number) in
              store.dispatch(.enterFloor(number: number))
            }
            .setSize(width: 200)
            .appear(originView: button, baseViewController: self)
        }).disposed(by: disposeBag)
    })

    navigationItem.titleView = UISearchBar().then {
      $0.rx.textDidBeginEditing.subscribe(onNext: { [unowned self] in
        self.searchWireframe.present(to: self.navigationController)
      }).disposed(by: disposeBag)
    }
  }
}

// MARK: - Style
private extension RoomMapViewController {
  func configureMap() {
    mapView.do {
      $0.mapType = .none
      $0.delegate = self
    }
  }

  func configurePathLine() {
    line.do {
      $0.map = mapView
      $0.strokeColor = .red
      $0.strokeWidth = 4
    }
  }

  func configurePositionMarker() {
    position = GMSMarker(position: kCLLocationCoordinate2DInvalid).then {
      $0.map = mapView
    }
  }
}

// MARK: - Business error
private extension RoomMapViewController {
  func handleBusinessError() {
    store.businessError.subscribe(onNext: {
      log.error($0)
    }).disposed(by: disposeBag)
  }
}

// MARK: - Subscribt presenter
private extension RoomMapViewController {
  func subscriptPath() {
    roomMapPresenter.currentPath
      .drive(onNext: { [unowned self] in self.line.path = $0 })
      .disposed(by: disposeBag)
  }

  func subscriptOverlay() {
    roomMapPresenter.currentOverlay
      .drive(onNext: { [unowned self] in
        self.mapView.clear()
        $0.map = self.mapView
        self.mapView.moveCamera(GMSCameraUpdate.setTarget($0.position, zoom: Float(CameraConstant.startZoom)))
      }).disposed(by: disposeBag)
  }

  func subscribtError() {
    store.networkError.map {
      UIAlertController(title: "Error", message: $0, preferredStyle: .alert).then {
        $0.addAction(UIAlertAction(title: "Cancel", style: .cancel))
      }
    }.subscribe(onNext: { [unowned self] in
      self.present($0, animated: true)
    }).disposed(by: disposeBag)
  }
}

// MARK: - Position
private extension RoomMapViewController {
  func subscriptOnVisualization() {
    positionInteractor.beacons.drive(onNext: { [unowned self] in
      self.beacons.forEach { $0.map = nil }
      self.beacons = $0
      for circle in $0 {
        GMSMarker(position: circle.position).do {
          $0.map = self.mapView
        }
        circle.map = self.mapView
      }
    }).disposed(by: disposeBag)
  }

  func subscriptPosition() {
    positionInteractor.position.drive(onNext: { [unowned self] in
      CATransaction.begin()
      CATransaction.setAnimationDuration(1)
      self.position.position = $0
      CATransaction.commit()
    }).disposed(by: disposeBag)
  }
}

// MARK: - Subscribt buttons
private extension RoomMapViewController {
  func subscriptOnButtons() {
    subscriptPositionButton()
    subscriptSendLogs()
    subscriptFavoriteButton()
  }

  func subscriptPositionButton() {
    positionButton.rx.tap.asObservable()
      .withLatestFrom(positionInteractor.position)
      .map(GMSCameraUpdate.setTarget)
      .subscribe(onNext: { [unowned self] in
        self.mapView.moveCamera($0)
      }).disposed(by: disposeBag)
  }

  func subscriptSendLogs() {
    sendLogs.rx.tap.subscribe(onNext: { [unowned self] in
      UIActivityViewController(activityItems: [filename], applicationActivities: nil).do {
        self.present($0, animated: true, completion: nil)
      }
    }).disposed(by: disposeBag)
  }

  func subscriptFavoriteButton() {
    //TODO only for demo. remove later
    var flag = false
    favourite.rx.tap.subscribe(onNext: {
      if !flag {
        self.favourite.image = #imageLiteral(resourceName: "ic_star_18pt")
      } else {
        self.favourite.image = #imageLiteral(resourceName: "ic_star_border")
      }
      flag = !flag
    }).disposed(by: disposeBag)
    self.roomMapPresenter.addToFavourite(click: favourite.rx.tap.asObservable()).disposed(by: disposeBag)
  }
}

// MARK: - GMSMapViewDelegate
extension RoomMapViewController: GMSMapViewDelegate {
  func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
    log.info("\"longitude\": \(coordinate.longitude), \"latitude\":\(coordinate.latitude)")
  }
}

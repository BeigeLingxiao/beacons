//
//  RxCLLocationManagerDelegateProxy.swift
//  RxExample
//
//  Created by Carlos García on 8/7/15.
//  Copyright © 2015 Krunoslav Zaher. All rights reserved.
//

import CoreLocation
import RxSwift
import RxCocoa

// Because of some problems with shipping app with rx to app store this and CLLocationManager + Rx were
// moved from official rxswift repo to rxexample (u can find an issue about it, just google). I think it's not
// important for us, so i decided to copy these files to project (Anton Nazarov). Feel free to modify and
// delete useless statements
extension CLLocationManager: HasDelegate {
  public typealias Delegate = CLLocationManagerDelegate
}

class RxCLLocationManagerDelegateProxy: DelegateProxy<CLLocationManager, CLLocationManagerDelegate>, DelegateProxyType, CLLocationManagerDelegate {

  public init(locationManager: CLLocationManager) {
    super.init(parentObject: locationManager, delegateProxy: RxCLLocationManagerDelegateProxy.self)
  }

  public static func registerKnownImplementations() {
    self.register { RxCLLocationManagerDelegateProxy(locationManager: $0) }
  }

  internal lazy var didUpdateLocationsSubject = PublishSubject<[CLLocation]>()
  internal lazy var didFailWithErrorSubject = PublishSubject<Error>()

  public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    _forwardToDelegate?.locationManager?(manager, didUpdateLocations: locations)
    didUpdateLocationsSubject.onNext(locations)
  }

  public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    _forwardToDelegate?.locationManager?(manager, didFailWithError: error)
    didFailWithErrorSubject.onNext(error)
  }

  deinit {
    self.didUpdateLocationsSubject.on(.completed)
    self.didFailWithErrorSubject.on(.completed)
  }
}

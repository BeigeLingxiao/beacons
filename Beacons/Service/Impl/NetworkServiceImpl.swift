//
//  NetworkServiceImpl.swift
//  Beacons
//
//  Created by Антон Назаров on 09.11.2017.
//  Copyright © 2017 com.epam All rights reserved.
//

import Alamofire
import RxAlamofire
import ObjectMapper
import AlamofireObjectMapper
import RxSwift

class NetworkServiceImpl: NetworkService {
  private let sessionManager: SessionManager

  init(sessionManager: SessionManager) {
    self.sessionManager = sessionManager
  }

  func getBuildings() -> Single<[Building]> {
    return Single<[Building]>.create { single in
      let disposable = self.getDataRequest(url: Configuration.url(for: Endpoint.buildings.rawValue))
        .subscribe(onNext: { $0.responseArray { (response: DataResponse<[Building]>) in
          switch response.result {
          case let .success(buildings):
            single(.success(buildings))
          case let .failure(error):
            single(.error(NetworkServiceImpl.mapAndLogError(error)))
          }
        }})
      return Disposables.create { disposable.dispose() }
    }
  }

  func getFloors(ofBuilding id: Int) -> Single<[Floor]> {
    return Single<[Floor]>.create { single in
      let disposable = self.getDataRequest(url: Configuration.url(for: Endpoint.building(id)))
        .subscribe(onNext: { $0.responseArray { (response: DataResponse<[Floor]>) in
          guard let floors = response.result.value else {
            log.error("Failed to parse building \(id)")
            single(.error(NetworkError.invalidFormat))
            return
          }
          single(.success(floors))
        }})
      return Disposables.create { disposable.dispose() }
    }
  }

  static func mapAndLogError(_ error: Error) -> NetworkError {
    guard let error = error as? AFError else {
      log.error("Unexpected error")
      return .invalidFormat
    }
    switch error {
    case .responseValidationFailed(let reason):
      log.error("Response validation failed: \(error.localizedDescription)")
      log.error("Failure Reason: \(reason)")
      return .invalidFormat
    default:
      log.error("Unhandled error")
      return .invalidFormat
    }
  }

  func getDataRequest(url: URLConvertible) -> Observable<DataRequest> {
    return sessionManager.rx.request(.get, url)
      .map {
        $0
          .validate(statusCode: [200])
          .validate(contentType: ["application/json"])
      }
  }
}

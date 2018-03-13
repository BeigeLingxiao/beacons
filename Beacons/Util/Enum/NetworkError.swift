//
//  NetworkError.swift
//  Beacons
//
//  Created by Антон Назаров on 09.11.2017.
//  Copyright © 2017 com.epam All rights reserved.
//

enum NetworkError: String, Error {
  case noInternetConnection = "No internet collection"
  case serviceNotAvailable = "No response from server"
  case invalidFormat = "Server API not consistent"

  init(statusCode: Int) {
    switch statusCode {
    case 503:
      self = .noInternetConnection
    default:
      self = .serviceNotAvailable
    }
  }
}

//
//  FindWayInteractorImpl.swift
//  Beacons
//
//  Created by Антон Назаров on 09.10.2017.
//  Copyright © 2017 com.epam All rights reserved.
//

import RxSwift

final class FindWayInteractorImpl: FindWayInteractor {
  private var solver: GraphSolver?
  private let vertexService: VertexService
  private let edgeService: EdgeService
  private let disposeBag = DisposeBag()

  var path: Observable<GMSPath>!

  init(vertexService: VertexService, edgeService: EdgeService, placeService: PlaceService, state: State) {
    self.vertexService = vertexService
    self.edgeService = edgeService

    state.enteredBuildingId
      .subscribe(onNext: {[unowned self] in
        self.configure(forBuilding: $0)
      }).disposed(by: disposeBag)

    path = Observable.combineLatest(
      state.position,
      state.choosenPlaceId
        .filter {
          switch $0 {
          case .notChoosen:
            return false
          case .choosen:
            return true
          }
        }.map {
          switch $0 {
          case let .choosen(value):
            return value
          default:
            throw BusinessError.noFloors
          }
        }.map(placeService.get)
      ).map { self.findPath(from: $0.0, toPlace: $0.1) }
  }

  private func configure(forBuilding id: Int) {
    solver = GraphSolver(
      vertexes: vertexService.getAll(fromBuilding: id),
      edges: edgeService.getAll(fromBuilding: id)
    )
  }
}

// MARK: - Find way
private extension FindWayInteractorImpl {
  func findPath(from pos: CLLocationCoordinate2D, toPlace place: Place) -> GMSPath {
    return GMSPath(path: GMSMutablePath().then {
      findWay(from: pos, to: place)
        .map { $0.pos }
        .forEach($0.add)
    })
  }

  func findWay(from point: CLLocationCoordinate2D, to place: Place) -> [Vertex] {
    guard let start = getNearestVertex(to: point), let finish = getNearestVertex(to: place.pos) else {
      log.error("Can't find start or finish point of path")
      return []
    }
    return findWay(from: start, to: finish)
  }

  func findWay(from: Vertex, to: Vertex) -> [Vertex] {
    guard let solver = solver else {
      log.error("Not configured graph solver")
      return []
    }
    return solver.findWay(from: from, to: to)
  }

  func getNearestVertex(to point: CLLocationCoordinate2D) -> Vertex? {
    return vertexService.getNearest(to: point)
  }
}

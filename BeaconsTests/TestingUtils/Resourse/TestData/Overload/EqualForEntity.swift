//
//  Overloads.swift
//  BeaconsTests
//
//  Created by Антон Назаров on 29/11/2017.
//  Copyright © 2017 com.epam All rights reserved.
//

import Nimble
import Realm
@testable import Beacons

//Building
func ==(lhs: Nimble.Expectation<Building>, rhs: Building) {
  _ = try! lhs.expression.evaluate()! == rhs
}

func ==(lhs: Building, rhs: Building) {
  expect(lhs.descr) == rhs.descr
  expect(lhs.urlString) == rhs.urlString
  expect(lhs.id) == rhs.id
  expect(lhs.name) == rhs.name
  expect(lhs.latitude) ==~ rhs.latitude
  expect(lhs.longitude) ==~ rhs.longitude
}

//Floor
func ==(lhs: Nimble.Expectation<Floor>, rhs: Floor) {
  _ = try! lhs.expression.evaluate()! == rhs
}

func ==(lhs: Floor, rhs: Floor) {
  expect(lhs.number) == rhs.number
  expect(lhs.height) == rhs.height
  expect(lhs.urlString) == rhs.urlString
  expect(lhs.width) == rhs.width
  expect(lhs.overlayNorthEastLatitude) == rhs.overlayNorthEastLatitude
  expect(lhs.overlayNorthEastLongitude) == rhs.overlayNorthEastLongitude
  expect(lhs.overlaySouthWestLatitude) == rhs.overlaySouthWestLatitude
  expect(lhs.overlaySouthWestLongitude) == rhs.overlaySouthWestLongitude

  expect(lhs.beacons).to(contain(exactly: rhs.beacons, expect: ==))
  expect(lhs.edges).to(contain(exactly: rhs.edges, expect: ==))
  expect(lhs.places).to(contain(exactly: rhs.places, expect: ==))
  expect(lhs.vertices).to(contain(exactly: rhs.vertices, expect: ==))
}

//Vertex
func ==(lhs: Nimble.Expectation<Vertex>, rhs: Vertex) {
  _ = try! lhs.expression.evaluate()! == rhs
}

func ==(lhs: Vertex, rhs: Vertex) {
  expect(lhs.id) == rhs.id
  expect(lhs.latitude) ==~ rhs.latitude
  expect(lhs.longitude) ==~ rhs.longitude
}

//Place
func ==(lhs: Nimble.Expectation<Place>, rhs: Place) {
  _ = try! lhs.expression.evaluate()! == rhs
}

func ==(lhs: Place, rhs: Place) {
  expect(lhs.id) == rhs.id
  expect(lhs.descr) == rhs.descr
  expect(lhs.latitude) ==~ rhs.latitude
  expect(lhs.longitude) ==~ rhs.longitude
  expect(lhs.type) == rhs.type
}

//Beacon
func ==(lhs: Nimble.Expectation<Beacon>, rhs: Beacon) {
  _ = try! lhs.expression.evaluate()! == rhs
}

func ==(lhs: Beacon, rhs: Beacon) {
  expect(lhs.uuidString) == rhs.uuidString
  expect(lhs.major) == rhs.major
  expect(lhs.minor) == rhs.minor
  expect(lhs.latitude) ==~ rhs.latitude
  expect(lhs.longitude) ==~ rhs.longitude
}

//Edge
func ==(lhs: Nimble.Expectation<Edge>, rhs: Edge) {
  _ = try! lhs.expression.evaluate()! == rhs
}

func ==(lhs: Edge, rhs: Edge) {
  expect(lhs.v1) == rhs.v1
  expect(lhs.v2) == rhs.v2
  expect(rhs.weight) == (rhs.weight)
}

//SyncInfo
func ==(lhs: Nimble.Expectation<SyncInfo>, rhs: SyncInfo) {
  _ = try! lhs.expression.evaluate()! == rhs
}

func ==(lhs: SyncInfo, rhs: SyncInfo) {
  expect(lhs.buildingId.value) == rhs.buildingId.value
  expect(lhs.isSyncOfConcreteBuilding) == rhs.isSyncOfConcreteBuilding
  expect(lhs.date) == rhs.date
}

//PlaceUserInfo
func ==(lhs: Nimble.Expectation<PlaceUserInfo>, rhs: PlaceUserInfo) {
  _ = try! lhs.expression.evaluate()! == rhs
}

func ==(lhs: PlaceUserInfo, rhs: PlaceUserInfo) {
  expect(lhs.id) == rhs.id
  expect(lhs.descr) == rhs.descr
  expect(lhs.isFavourite) == rhs.isFavourite
  expect(lhs.recentDate) == rhs.recentDate
}

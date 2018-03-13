//
//  GraphSolverTest.swift
//  BeaconsTests
//
//  Created by Антон Назаров on 10.10.2017.
//  Copyright © 2017 com.epam All rights reserved.
//

import Quick
import Nimble
import ObjectMapper
@testable import Beacons

class GraphSolver: QuickSpec {
  override func spec() {
    //Test data from https://www.hackerrank.com/challenges/5595 (format description here) test case2
    let data = getTestDataForGraph(numbeOfFile: 1)
    let solver = Beacons.GraphSolver(vertexes: data.vertexes, edges: data.edges)
    describe("Graph solver test") {
      for fileNum in 1...VertexForGraph.N {
        context("Test file #\(fileNum)") {
          for vertexIdx in 1..<data.vertexes.count {
            it("correctly find distance from 0 to \(vertexIdx) vertex") {
              let actual = solver.findWayWithDistance(from: data.vertexes[0], to: data.vertexes[vertexIdx]).distance
              let expected = data.answers[vertexIdx - 1]
              expect(actual).to(beCloseTo(expected))
            }
          }
        }
      }
    }
  }

  //swiftlint:disable:next large_tuple
  private func getTestDataForGraph(numbeOfFile: Int) -> (vertexes: [Vertex], edges: [Edge], answers: [Float]) {
    let data = try! String(contentsOfFile: Bundle(for: type(of: self)).path(forResource: "vertexForGraph\(numbeOfFile)", ofType: "txt")!, encoding: .utf8)
    let graphInfo = data.components(separatedBy: .newlines)
    return (
      createVertexes(count: Int(graphInfo[0])!),
      parseEdges(graphInfo: graphInfo),
      parseAnswers(answersInfo: graphInfo[graphInfo.count - 2])
    )
  }

  private func createVertexes(count: Int) -> [Vertex] {
    var vertexes = [Vertex]()
    for i in 0..<count {
      let v = Vertex()
      v.id = i + 1
      vertexes.append(v)
    }
    return vertexes
  }

  private func parseEdges(graphInfo: [String]) -> [Edge] {
    var edges = [Edge]()
    let edgesN = Int(graphInfo[1])!
    for edgeIdx in 2...(edgesN + 1) {
      let edge = parseEdge(edgeInfo: graphInfo[edgeIdx].components(separatedBy: .whitespaces))
      edges.append(edge)
    }
    return edges
  }

  private func parseAnswers(answersInfo: String) -> [Float] {
    return answersInfo.components(separatedBy: .whitespaces).map {
      Float(Int($0)!)
    }
  }

  private func parseEdge(edgeInfo: [String]) -> Edge {
    let e = Edge()
    e.v1 = Int(edgeInfo[0])!
    e.v2 = Int(edgeInfo[1])!
    e.weight = Float(edgeInfo[2])!
    return e
  }
}

//
//  GraphSolver.swift
//  Beacons
//
//  Created by Антон Назаров on 08.10.2017.
//  Copyright © 2017 com.epam All rights reserved.
//

import GameplayKit

class GraphSolver {
  private let graph: GKGraph
  private var vertexToNode = [Int: Node]()

  init(vertexes: [Vertex], edges: [Edge]) {
    if vertexes.isEmpty || edges.isEmpty {
      log.warning("Init graphSolver with strange param: edges \(edges.count); vertexes \(vertexes.count)")
    }
    graph = GKGraph()
    for vertex in vertexes {
      vertexToNode[vertex.id] = Node(vertex: vertex)
    }
    for edge in edges {
      guard let node1 = vertexToNode[edge.v1], let node2 = vertexToNode[edge.v2] else {
        fatalError("Vertexes and edges not consistent")
      }
      node1.addConnection(to: node2, weight: edge.weight)
      node2.addConnection(to: node1, weight: edge.weight)
    }
  }

  func findWay(from: Vertex, to: Vertex) -> [Vertex] {
    return findNodesPath(from: from, to: to).map { $0.vertex }
  }

  func findWayWithDistance(from: Vertex, to: Vertex) -> (path: [Vertex], distance: Float) {
    let nodes = findNodesPath(from: from, to: to)
    var total = Float(0)
    for i in 0..<(nodes.count - 1) {
      total += nodes[i].cost(to: nodes[i + 1])
    }
    return (nodes.map { $0.vertex }, total)
  }

  private func findNodesPath(from: Vertex, to: Vertex) -> [Node] {
    guard let node1 = vertexToNode[from.id], let node2 = vertexToNode[to.id] else {
      return []
    }
    return graph.findPath(from: node1, to: node2).flatMap { $0 as? Node }
  }
}

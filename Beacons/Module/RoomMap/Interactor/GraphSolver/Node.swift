//
//  Node.swift
//  Beacons
//
//  Created by Антон Назаров on 08.10.2017.
//  Copyright © 2017 com.epam All rights reserved.
//

import GameplayKit

class Node: GKGraphNode {
  var vertex: Vertex!
  var travelCost = [GKGraphNode: Float]()

  init(vertex: Vertex) {
    self.vertex = vertex
    super.init()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init()
  }

  override func cost(to node: GKGraphNode) -> Float {
    return travelCost[node] ?? 0
  }

  func addConnection(to node: GKGraphNode, weight: Float) {
    addConnections(to: [node], bidirectional: true)
    travelCost[node] = weight
    (node as? Node)?.travelCost[self] = weight
  }
}

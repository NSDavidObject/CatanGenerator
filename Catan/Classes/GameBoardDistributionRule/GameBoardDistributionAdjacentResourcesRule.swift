//
//  GameBoardDistributionAdjacentResourcesRule.swift
//  Catan
//
//  Created by David Elsonbaty on 1/1/18.
//  Copyright © 2018 David Elsonbaty. All rights reserved.
//

import Foundation

struct GameBoardDistributionAdjacentResourcesRule: GameBoardDistributionRule {
    static func isHexagonValid(_ hexagon: GameBoardPiece.Hexagon, withAdjacentHexagons neighbors: [GameBoardPiece.Hexagon]) -> Bool {
        guard let resource = hexagon.resource, neighbors.count > 0 else { return true }
        
        if neighbors.allPass({ $0.resource != resource }) {
            print(neighbors.flatMap({ $0.resource?.debugDescription }), hexagon.resource!.debugDescription)
            return true
        }
        
        return neighbors.allPass({ $0.resource != resource })
    }
}

struct GameBoardDistributionAdjacentGoldResourcesRule: GameBoardDistributionRule {
    static func isHexagonValid(_ hexagon: GameBoardPiece.Hexagon, withAdjacentHexagons neighbors: [GameBoardPiece.Hexagon]) -> Bool {
        guard let resource = hexagon.resource, resource == .gold else { return true }
        return neighbors.allPass({ $0.resource != resource })
    }
}

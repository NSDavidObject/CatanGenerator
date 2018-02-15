//
//  GameBoardDistributionAdjacentHighProbabilityRule.swift
//  Catan
//
//  Created by David Elsonbaty on 1/1/18.
//  Copyright © 2018 David Elsonbaty. All rights reserved.
//

import Foundation

struct GameBoardDistributionAdjacentHighProbabilityRule: GameBoardDistributionRule {
    static func isHexagonValid(_ hexagon: GameBoardPiece.Hexagon, withAdjacentHexagons neighbors: [GameBoardPiece.Hexagon]) -> Bool {
        guard let diceCombination = hexagon.diceCombination, diceCombination.probability.isHighest else { return true }
        return neighbors.allPass({ $0.diceCombination?.probability.isHighest == false })
    }
}

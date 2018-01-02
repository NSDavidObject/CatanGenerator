//
//  GameBoardDistributionRule.swift
//  Catan
//
//  Created by David Elsonbaty on 1/1/18.
//  Copyright © 2018 David Elsonbaty. All rights reserved.
//

import Foundation

protocol GameBoardDistributionRule {
    static func isHexagonValid(_ hexagon: GameBoardPiece.Hexagon, withAdjacentHexagons neighbors: [GameBoardPiece.Hexagon]) -> Bool
}

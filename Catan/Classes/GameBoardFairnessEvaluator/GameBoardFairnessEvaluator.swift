//
//  GameBoardFairnessEvaluator.swift
//  Catan
//
//  Created by David Elsonbaty on 9/30/17.
//  Copyright © 2017 David Elsonbaty. All rights reserved.
//

import Foundation

protocol GameBoardFairnessEvaluator {
    static func isGameBoardFairlySetup(_ gameBoard: GameBoard) -> Bool
}

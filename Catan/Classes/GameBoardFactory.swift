//
//  GameBoardFactory.swift
//  Catan
//
//  Created by David Elsonbaty on 9/30/17.
//  Copyright © 2017 David Elsonbaty. All rights reserved.
//

import Foundation

struct GameBoardFactory {
    
    static let gameBoardFairnessEvaluators: [GameBoardFairnessEvaluator.Type] = [
        GameBoardProbabilityDistributionFairnessEvaluator.self,
        GameBoardResourcesDistrubutionFairnessEvaluator.self
    ]
    
    static func fairlyDistributedGameBoard(ofType type: GameType) -> GameBoard {
        let generatedGameBoard = type.definition.generatedBoard()
        let isGeneratedGameBoardFairlyDistributed = GameBoardFactory.gameBoardFairnessEvaluators.allPass({ $0.isGameBoardFairlySetup(generatedGameBoard) })
        return isGeneratedGameBoardFairlyDistributed ? generatedGameBoard : fairlyDistributedGameBoard(ofType: type)
    }
}

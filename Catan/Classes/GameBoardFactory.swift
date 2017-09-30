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
    
    static func gameBoard(ofType type: GameType) -> GameBoard {
        let generatedGameBoardPieces = type.definition.generatedBoardPieces()
        return GameBoard(type: type, pieces: generatedGameBoardPieces)
    }
    
    static func fairlyDistributedGameBoard(ofType type: GameType) -> GameBoard {
        let generatedGameBoard = gameBoard(ofType: type)
        let isGeneratedGameBoardFairlyDistributed = GameBoardFactory.gameBoardFairnessEvaluators.allPass({ $0.isGameBoardFairlySetup(generatedGameBoard) })
        return isGeneratedGameBoardFairlyDistributed ? generatedGameBoard : fairlyDistributedGameBoard(ofType: type)
    }
}

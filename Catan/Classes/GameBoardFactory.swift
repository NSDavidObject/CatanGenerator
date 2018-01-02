//
//  GameBoardFactory.swift
//  Catan
//
//  Created by David Elsonbaty on 9/30/17.
//  Copyright © 2017 David Elsonbaty. All rights reserved.
//

import Foundation

struct GameBoardFactory {
    
    private static let gameBoardFairnessEvaluators: [GameBoardFairnessEvaluator.Type] = [

    ]
    
    private static func gameBoard(ofType type: GameType) -> GameBoard {
        let generatedGameBoardPieces = type.definition.generatedBoardPieces()
        return GameBoard(type: type, pieces: generatedGameBoardPieces)
    }
    
    static func fairlyDistributedGameBoard(ofType type: GameType) -> GameBoard {
        var generatedGameBoard = gameBoard(ofType: type)
        while !GameBoardFactory.gameBoardFairnessEvaluators.allPass({ $0.isGameBoardFairlySetup(generatedGameBoard) }) {
            generatedGameBoard = gameBoard(ofType: type)
        }
        return generatedGameBoard
    }
}

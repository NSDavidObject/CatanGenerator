//
//  GameBoardResourceGroupingFairnessEvaluator.swift
//  Catan
//
//  Created by David Elsonbaty on 10/7/17.
//  Copyright © 2017 David Elsonbaty. All rights reserved.
//

import Foundation

struct GameBoardResourceGroupingFairnessEvaluator: GameBoardFairnessEvaluator {
    
    static func isGameBoardFairlySetup(_ gameBoard: GameBoard) -> Bool {
        guard var currentGameBoardPiecePosition: DoubleArrayPosition = DoubleArrayPosition.firstPosition(in: gameBoard.pieces) else { return true }
        
        if isCurrentResourcePositionInGroup(position: currentGameBoardPiecePosition, inGameBoard: gameBoard) {
            return false
        }
        
        while let nextGameBoardPiecePosition = currentGameBoardPiecePosition.nextSubsequentPosition(in: gameBoard.pieces) {
            currentGameBoardPiecePosition = nextGameBoardPiecePosition
            if isCurrentResourcePositionInGroup(position: currentGameBoardPiecePosition, inGameBoard: gameBoard) {
                return false
            }
        }
        
        return true
    }
    
    static func isCurrentResourcePositionInGroup(position currentPosition: DoubleArrayPosition, inGameBoard gameBoard: GameBoard) -> Bool {
        
        func resourceValue(at position: DoubleArrayPosition) -> Resource? {
            return position.element(inDoubleArray: gameBoard.pieces)?.hexagon?.resource
        }
        
        guard let currentResourse = resourceValue(at: currentPosition) else { return false }
        
        let currentRow = currentPosition.positionY
        let nextRowDown = currentRow.successor
        guard gameBoard.pieces.count > nextRowDown else { return false }
        
        func isPositionAtTheTopTipOfATriangleGroup() -> Bool {
            guard let bottomLeftPosition = currentPosition.adjacentPosition(.bottomLeft, inGameBoard: gameBoard),
                let bottomRightPosition = currentPosition.adjacentPosition(.bottomRight, inGameBoard: gameBoard) else { return false }
            return (currentResourse == resourceValue(at: bottomLeftPosition)) && (currentResourse == resourceValue(at: bottomRightPosition))
        }
        
        func isPositionAtTheTopLeftOfTriangleGroup() -> Bool {
            guard let rightPosition = currentPosition.adjacentPosition(.right, inGameBoard: gameBoard),
                let bottomRightPosition = currentPosition.adjacentPosition(.bottomRight, inGameBoard: gameBoard) else { return false }
            return (currentResourse == resourceValue(at: rightPosition)) && (currentResourse == resourceValue(at: bottomRightPosition))
        }
            
        return isPositionAtTheTopTipOfATriangleGroup() || isPositionAtTheTopLeftOfTriangleGroup()
    }
}

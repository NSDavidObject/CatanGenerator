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
        
        func leftIndexOffset(toRowIndex: Int) -> Int {
            let fromRow = gameBoard.pieces[currentPosition.positionY]
            let toRow = gameBoard.pieces[toRowIndex]
            return -((fromRow.count < toRow.count) ? 0 : 1)
        }
        
        func rightIndexOffset(toRowIndex: Int) -> Int {
            let fromRow = gameBoard.pieces[currentPosition.positionY]
            let toRow = gameBoard.pieces[toRowIndex]
            return ((fromRow.count < toRow.count) ? 1 : 0)
        }
        
        func isPositionAtTheTopTipOfATriangleGroup() -> Bool {
            let bottomLeftPosition = DoubleArrayPosition(positionX: currentPosition.positionX + leftIndexOffset(toRowIndex: nextRowDown), positionY: nextRowDown)
            let bottomRightPosition = DoubleArrayPosition(positionX: bottomLeftPosition.positionX.successor, positionY: nextRowDown)
            return (currentResourse == resourceValue(at: bottomLeftPosition)) && (currentResourse == resourceValue(at: bottomRightPosition))
        }
        
        func isPositionAtTheTopLeftOfTriangleGroup() -> Bool {
            let rightPosition = DoubleArrayPosition(positionX: currentPosition.positionX.successor, positionY: currentPosition.positionY)
            let bottomRightPosition = DoubleArrayPosition(positionX: currentPosition.positionX + rightIndexOffset(toRowIndex: nextRowDown), positionY: nextRowDown)
            return (currentResourse == resourceValue(at: rightPosition)) && (currentResourse == resourceValue(at: bottomRightPosition))
        }
            
        return isPositionAtTheTopTipOfATriangleGroup() || isPositionAtTheTopLeftOfTriangleGroup()
    }
}

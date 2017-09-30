//
//  GameBoardResourcesDistrubutionFairnessEvaluator.swift
//  Catan
//
//  Created by David Elsonbaty on 9/30/17.
//  Copyright © 2017 David Elsonbaty. All rights reserved.
//

import Foundation

struct GameBoardResourcesDistrubutionFairnessEvaluator: GameBoardFairnessEvaluator {
    
    static let maxNumberOfResourcesOfCloseProximity: Int = 3
    
    static func isGameBoardFairlySetup(_ gameBoard: GameBoard) -> Bool {
        guard var currentGameBoardPiecePosition: DoubleArrayPosition = DoubleArrayPosition.firstPosition(in: gameBoard.pieces) else { return true }
        
        func isCurrentResourcePositionFairlyDistributed() -> Bool {
            let numberOfAdjacentSameResources = numberOfAdjacentSameResouces(to: currentGameBoardPiecePosition, inGameBoard: gameBoard)
            return numberOfAdjacentSameResources < GameBoardResourcesDistrubutionFairnessEvaluator.maxNumberOfResourcesOfCloseProximity.predecessor
        }
        
        if !isCurrentResourcePositionFairlyDistributed() {
            return false
        }
        
        while let nextGameBoardPiecePosition = currentGameBoardPiecePosition.nextSubsequentPosition(in: gameBoard.pieces) {
            currentGameBoardPiecePosition = nextGameBoardPiecePosition
            if !isCurrentResourcePositionFairlyDistributed() {
                return false
            }
        }
        
        return true
    }
    
    static func numberOfAdjacentSameResouces(to originalPosition: DoubleArrayPosition, inGameBoard gameBoard: GameBoard) -> Int {
        typealias VisitedPositions = Set<DoubleArrayPosition>
        
        var setOfVisitedPositions: VisitedPositions = [originalPosition]
        func internal_numberOfAdjacentSameResouces(to position: DoubleArrayPosition, inGameBoard gameBoard: GameBoard) -> Int {
            guard let currentResource = position.element(inDoubleArray: gameBoard.pieces)?.hexagon?.resource else { return 0 }
            
            func numberOfAdjacentSameResources(from checkingPosition: DoubleArrayPosition) -> Int {
                guard !setOfVisitedPositions.contains(checkingPosition) else { return 0 }
                setOfVisitedPositions.insert(checkingPosition)
                
                guard let resource = checkingPosition.element(inDoubleArray: gameBoard.pieces)?.hexagon?.resource, currentResource == resource else { return 0 }
                return 1 + internal_numberOfAdjacentSameResouces(to: checkingPosition, inGameBoard: gameBoard)
            }
            
            func leftIndexOffset(toRowIndex: Int) -> Int {
                let fromRow = gameBoard.pieces[position.positionY]
                let toRow = gameBoard.pieces[toRowIndex]
                return -((fromRow.count < toRow.count) ? 0 : 1)
            }
            
            func rightIndexOffset(toRowIndex: Int) -> Int {
                let fromRow = gameBoard.pieces[position.positionY]
                let toRow = gameBoard.pieces[toRowIndex]
                return ((fromRow.count < toRow.count) ? 1 : 0)
            }
            
            var numberOfSameResources: Int = 0
            
            // Horizontal directions
            if let leftPosition = DoubleArrayPosition(positionX: position.positionX.predecessor, positionY: position.positionY, inDoubleArray: gameBoard.pieces) {
                numberOfSameResources += numberOfAdjacentSameResources(from: leftPosition)
            }
            if let rightPosition = DoubleArrayPosition(positionX: position.positionX.successor, positionY: position.positionY, inDoubleArray: gameBoard.pieces) {
                numberOfSameResources += numberOfAdjacentSameResources(from: rightPosition)
            }
            
            // Top row directions
            var positionYToBeChecked = position.positionY.successor
            if let bottomLeftPosition = DoubleArrayPosition(positionX: position.positionX + leftIndexOffset(toRowIndex: positionYToBeChecked), positionY: positionYToBeChecked, inDoubleArray: gameBoard.pieces) {
                numberOfSameResources += numberOfAdjacentSameResources(from: bottomLeftPosition)
            }
            if let bottomRightPosition = DoubleArrayPosition(positionX: position.positionX + rightIndexOffset(toRowIndex: positionYToBeChecked), positionY: positionYToBeChecked, inDoubleArray: gameBoard.pieces) {
                numberOfSameResources += numberOfAdjacentSameResources(from: bottomRightPosition)
            }
            
            // Bottom row directions
            positionYToBeChecked = position.positionY.predecessor
            if let topRightPosition = DoubleArrayPosition(positionX: position.positionX + rightIndexOffset(toRowIndex: positionYToBeChecked), positionY: positionYToBeChecked, inDoubleArray: gameBoard.pieces) {
                numberOfSameResources += numberOfAdjacentSameResources(from: topRightPosition)
            }
            
            return numberOfSameResources
        }
        
        return internal_numberOfAdjacentSameResouces(to: originalPosition, inGameBoard: gameBoard)
    }
}

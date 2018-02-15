//
//  GameBoardResourcesDistrubutionFairnessEvaluator.swift
//  Catan
//
//  Created by David Elsonbaty on 9/30/17.
//  Copyright © 2017 David Elsonbaty. All rights reserved.
//

import Foundation

private extension GameType {
    
    var maxNumberOfResourcesOfCloseProximitry: Int {
        switch self {
        case .classic, .seafarers:
            return 2
        case .extendedClassic:
            return 2
        }
    }
}

struct GameBoardResourcesDistrubutionFairnessEvaluator: GameBoardFairnessEvaluator {
    
    static func isGameBoardFairlySetup(_ gameBoard: GameBoard) -> Bool {
        guard var currentGameBoardPiecePosition: DoubleArrayPosition = DoubleArrayPosition.firstPosition(in: gameBoard.pieces) else { return true }
        
        func isCurrentResourcePositionFairlyDistributed() -> Bool {
            let numberOfAdjacentSameResources = numberOfAdjacentSameResouces(to: currentGameBoardPiecePosition, inGameBoard: gameBoard)
            return numberOfAdjacentSameResources < gameBoard.type.maxNumberOfResourcesOfCloseProximitry
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
            
            var numberOfSameResources: Int = 0
            
            let adjacentPositions: [DoubleArrayPosition.Adjacent] = [.left, .right, .bottomLeft, .bottomRight, .topRight]
            for adjacentPosition in adjacentPositions {
                if let doubleArrayPosition = position.adjacentPosition(adjacentPosition, inGameBoard: gameBoard) {
                    numberOfSameResources += numberOfAdjacentSameResources(from: doubleArrayPosition)
                }
            }
            
            return numberOfSameResources
        }
        
        return internal_numberOfAdjacentSameResouces(to: originalPosition, inGameBoard: gameBoard)
    }
}

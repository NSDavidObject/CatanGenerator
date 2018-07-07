//
//  GameBoardResourcesDistrubutionRepetitionEvaluator.swift
//  Catan
//
//  Created by David Elsonbaty on 9/30/17.
//  Copyright © 2017 David Elsonbaty. All rights reserved.
//

import Foundation
import CommonUtilities

private extension GameType {
    
    var maxNumberOfResourcesOfCloseProximitry: Int {
        switch self {
        case .classic:
            return 1
        case .extendedClassic:
            return 4
        }
    }
}

struct GameBoardResourcesDistrubutionRepetitionEvaluator: GameBoardFairnessEvaluator {
    
    static func isGameBoardFairlySetup(_ gameBoard: GameBoard) -> Bool {
        guard var currentGameBoardPiecePosition: DoubleArrayPosition = DoubleArrayPosition.firstPosition(in: gameBoard.pieces) else { return true }
        
        func isCurrentResourceOfCloseProximityToSameResource() -> Bool {
            let numberOfAdjacentSameResources = numberOfAdjacentSameResouces(to: currentGameBoardPiecePosition, inGameBoard: gameBoard)
            return numberOfAdjacentSameResources >= 1
        }
        
        var numberResourcesOfCloseProximity: Int = Int(isCurrentResourceOfCloseProximityToSameResource())
        while let nextGameBoardPiecePosition = currentGameBoardPiecePosition.nextSubsequentPosition(in: gameBoard.pieces) {
            currentGameBoardPiecePosition = nextGameBoardPiecePosition
            numberResourcesOfCloseProximity += Int(isCurrentResourceOfCloseProximityToSameResource())
            if numberResourcesOfCloseProximity > gameBoard.type.maxNumberOfResourcesOfCloseProximitry { return false }
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
                return internal_numberOfAdjacentSameResouces(to: checkingPosition, inGameBoard: gameBoard).successor
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

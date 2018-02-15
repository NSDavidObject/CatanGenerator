//
//  GameDefinition.swift
//  Catan
//
//  Created by David Elsonbaty on 8/20/17.
//  Copyright © 2017 David Elsonbaty. All rights reserved.
//

import Foundation

enum GameBoardPiecePlaceholder {
    case empty
    case port(location: Port.Location)
    case hexagon
}

protocol GameDefinition {
    static var distructionRules: [GameBoardDistributionRule.Type] { get }

    static var layout: [[GameBoardPiecePlaceholder]] { get }
    static var portsList: [(port: Port, count: Int)] { get }
    static var resourcesList: [(resource: Resource, count: Int)] { get }
    static var diceCombinationsList: [(combination: DiceCombination, count: Int)] { get }
}

extension GameDefinition {
    
    static var numberOfHexagons: Int {
        return Self.layout.reduce(0, { (count, row) -> Int in
            return count + row.reduce(0, { (rowCount, placeHolder) -> Int in
                if case .hexagon = placeHolder {
                    return rowCount + 1
                }
                return rowCount
            })
        })
    }
    
    static var ports: [Port] {
        return constructArray(from: Self.portsList)
    }
    
    static var resources: [Resource] {
        return constructArray(from: Self.resourcesList)
    }
    
    static var diceCombinations: [DiceCombination] {
        return constructArray(from: Self.diceCombinationsList)
    }
    
    private static func constructArray<T>(from elements: [(T, Int)]) -> [T] {
        var allElements: [T] = []
        for (element, count) in elements {
            for _ in 0..<count {
                allElements.append(element)
            }
        }
        return allElements
    }
}

extension GameDefinition {
    
    private static func randomHexagons(count: Int) -> [GameBoardPiece.Hexagon] {
        var randomCombinationsIterator = self.diceCombinations.shuffled().makeIterator()
        let resourceHexagons = resources.map { resource -> GameBoardPiece.Hexagon in
            guard let nextRandomCombination = randomCombinationsIterator.next() else { fatalError("Not enough combinations provided for provided resources") }
            return .resource(resource, value: nextRandomCombination)
        }
        
        let numberOfHexagons = resourceHexagons.count
        let theifHexagonsCount = count - numberOfHexagons
        let theifHexagons = (0..<theifHexagonsCount).map({ _ in GameBoardPiece.Hexagon.theif })
        return (resourceHexagons + theifHexagons).shuffled()
    }
    
    static func generatedBoardPieces() -> [[GameBoardPiece]] {
        let gameBoardEmptyPieces: [[GameBoardPiece]] = Self.layout.map { (row) -> [GameBoardPiece] in
            return row.map({ (placeholder) -> GameBoardPiece in
                return .empty
            })
        }

        let gameBoard = GameBoard(type: .classic, pieces: gameBoardEmptyPieces)
        
        var randomPortsIterator = self.ports.shuffled().makeIterator()
        var randomHexagons = self.randomHexagons(count: numberOfHexagons)
        
        var generatedBoard: [[GameBoardPiece]] = []
        for (rowIndex, row) in Self.layout.enumerated() {
            var currentRow: [GameBoardPiece] = []
            for (itemIndex, placeholder) in row.enumerated() {
                switch placeholder {
                case GameBoardPiecePlaceholder.empty:
                    currentRow.append(GameBoardPiece.empty)
                case GameBoardPiecePlaceholder.hexagon:
                    
                    let position = DoubleArrayPosition(positionX: itemIndex, positionY: rowIndex)
                    var adjacentHexagons: [GameBoardPiece.Hexagon] = []
                    
                    // Top left
                    if let topLeftPosition = position.adjacentPosition(.topLeft, inGameBoard: gameBoard) {
                        if let hexagon = generatedBoard[topLeftPosition.positionY][topLeftPosition.positionX].hexagon {
                            adjacentHexagons.append(hexagon)
                        }
                    }
                    
                    // Top Right
                    if let topRightPosition = position.adjacentPosition(.topRight, inGameBoard: gameBoard) {
                        if let hexagon = generatedBoard[topRightPosition.positionY][topRightPosition.positionX].hexagon {
                            adjacentHexagons.append(hexagon)
                        }
                    }
                    
                    // Handle left case
                    if let leftHexagon = currentRow.last?.hexagon {
                        adjacentHexagons.append(leftHexagon)
                    }
                    
                    guard let nextHexagon = randomHexagons.dropFirst(where: { hexagon in
                        return distructionRules.allPass({ $0.isHexagonValid(hexagon, withAdjacentHexagons: adjacentHexagons) })
                    }) else {
                        // Stuck without any options while sticking with the no adjacent same resources rule!
                        return Self.generatedBoardPieces()
                    }
                    
                    currentRow.append(GameBoardPiece.hexagon(nextHexagon))
                case GameBoardPiecePlaceholder.port(location: let location):
                    guard let nextPort = randomPortsIterator.next() else { fatalError("Not enough ports for board layout provided") }
                    currentRow.append(GameBoardPiece.port(nextPort, location: location))
                }
            }
            generatedBoard.append(currentRow)
        }
        
        assert(randomPortsIterator.next() == nil, "Too many ports provided for board layout")
        assert(randomHexagons.count == 0, "Too many hexagons provided for board layout")
        
        return generatedBoard
    }
}

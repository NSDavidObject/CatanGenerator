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
    
    static func generatedBoard() -> GameBoard {
        var randomPortsIterator = self.ports.shuffled().makeIterator()
        var randomHexagonsIterator = randomHexagons(count: numberOfHexagons).makeIterator()
        let generatedBoardPieces = Self.layout.map { gameBoardPiecePlaceholders -> [GameBoardPiece] in
            return gameBoardPiecePlaceholders.map({ placeholder -> GameBoardPiece in
                switch placeholder {
                case GameBoardPiecePlaceholder.empty:
                    return GameBoardPiece.empty
                case GameBoardPiecePlaceholder.hexagon:
                    guard let nextHexagon = randomHexagonsIterator.next() else { fatalError("Not enough hexagons for board layout provided") }
                    return GameBoardPiece.hexagon(nextHexagon)
                case GameBoardPiecePlaceholder.port(location: let location):
                    guard let nextPort = randomPortsIterator.next() else { fatalError("Not enough ports for board layout provided") }
                    return GameBoardPiece.port(nextPort, location: location)
                }
            })
        }
        
        assert(randomPortsIterator.next() == nil, "Too many ports provided for board layout")
        assert(randomHexagonsIterator.next() == nil, "Too many hexagons proviced for board layout")
        
        let gameBoard = GameBoard(pieces: generatedBoardPieces)
        return gameBoard.isEvenlySetup() ? gameBoard : generatedBoard()
    }
}

//
//  GameDefinition.swift
//  Catan
//
//  Created by David Elsonbaty on 8/20/17.
//  Copyright © 2017 David Elsonbaty. All rights reserved.
//

import Foundation

enum LocationType {
    case normal
    case island
    case fog
}

enum GameBoardPiecePlaceholder {
    case empty
    case fog
    case island
    case hexagon
    case plainWater
    case port(location: Port.Location)
    case waterPort(location: Port.Location)
    
    var location: LocationType? {
        switch self {
        case .hexagon: return .normal
        case .island: return .island
        case .fog: return .fog
        default: return nil
        }
    }
}

protocol GameDefinition {
    typealias Ports = (port: Port, count: Int)
    typealias Resources = (resource: Resource, count: Int)
    typealias DiceCombinations = (combination: DiceCombination, count: Int)
    
    static var distributionRules: [GameBoardDistributionRule.Type] { get }

    static var layout: [[GameBoardPiecePlaceholder]] { get }
    static var portsList: [Ports] { get }
    
    static var resources: [LocationType: [Resources]] { get }
    static var theifsCount: [LocationType: Int] { get }
    static var watersCount: [LocationType: Int] { get }
    static var diceCombinations: [LocationType: [DiceCombinations]] { get }
}

extension GameDefinition {
    
    static var ports: [Port] {
        return constructArray(from: Self.portsList)
    }
    
    static var hexagons: [LocationType: [GameBoardPiece.Hexagon]] {
        let shuffledResources = self.shuffledResources
        let shuffledDiceCombinations = self.shuffledDiceCombinations
        guard let combined = shuffledResources.combine(withDictionary: shuffledDiceCombinations) else { fatalError() }
        
        // Ensure resources count match dice combinations count
        guard combined.allPass({ $0.value.0.count == $0.value.1.count }) else { fatalError() }
        
        let resourceHexagons = combined.mapValues({ (resources, diceCombinations) -> [GameBoardPiece.Hexagon] in
            let zippedCombinations = zip(resources, diceCombinations)
            return zippedCombinations.map({ hexagonInfo -> GameBoardPiece.Hexagon in
                return GameBoardPiece.Hexagon.resource(hexagonInfo.0, value: hexagonInfo.1)
            })
        })
        
        // Ensure no gold tiles are mapped to high probability numbers
        guard resourceHexagons.allPass({ $0.value.allPass({ !$0.isGoldWithHighProbability }) }) else { return self.hexagons }
        
        let watersHexagons = Self.watersCount.mapValues({ $0.map({ _ in GameBoardPiece.Hexagon.water }) })
        guard let combinedWithWaterHexagons = resourceHexagons.combine(withDictionary: watersHexagons) else { fatalError() }
        let resourceAndWaterHexagons = combinedWithWaterHexagons.mapValues({ (hexagons) -> [GameBoardPiece.Hexagon] in
            return (hexagons.0 + hexagons.1).shuffled()
        })
        
        let theifHexagons = Self.theifsCount.mapValues({ $0.map({ _ in GameBoardPiece.Hexagon.theif }) })
        guard let combinedHexagons = resourceAndWaterHexagons.combine(withDictionary: theifHexagons) else { fatalError() }
        return combinedHexagons.mapValues({ (hexagons) -> [GameBoardPiece.Hexagon] in
            return (hexagons.0 + hexagons.1).shuffled()
        })
    }
    
    private static var shuffledResources: [LocationType: [Resource]] {
        return Self.resources.mapValues({ (definitionResource) -> [Resource] in
            return constructArray(from: definitionResource).shuffled()
        })
    }
    
    private static var shuffledDiceCombinations: [LocationType: [DiceCombination]] {
        return Self.diceCombinations.mapValues({ (diceCombination) -> [DiceCombination] in
            return constructArray(from: diceCombination).shuffled()
        })
    }
    
    private static func constructArray<T>(from elements: [(T, Int)]) -> [T] {
        return elements.flatMap({ (item, count) -> [T] in
            return Array(repeating: item, count: count)
        })
    }
}

extension GameDefinition {

    static func generatedBoardPieces() -> [[GameBoardPiece]] {
        let gameBoardEmptyPieces: [[GameBoardPiece]] = Self.layout.map { $0.map({ _ in GameBoardPiece.empty }) }
        let gameBoard = GameBoard(type: .classic, pieces: gameBoardEmptyPieces)
        
        var randomPortsIterator = self.ports.shuffled().makeIterator()
        var randomHexagons = self.hexagons
        
        var generatedBoard: [[GameBoardPiece]] = []
        for (rowIndex, row) in Self.layout.enumerated() {
            var currentRow: [GameBoardPiece] = []
            for (itemIndex, placeholder) in row.enumerated() {
                switch placeholder {
                case .plainWater:
                    currentRow.append(GameBoardPiece.water(.plain))
                case .waterPort(location: let location):
                    guard let nextPort = randomPortsIterator.next() else { fatalError("Not enough ports for board layout provided") }
                    currentRow.append(GameBoardPiece.water(.port(nextPort, location: location)))
                case GameBoardPiecePlaceholder.empty:
                    currentRow.append(GameBoardPiece.empty)
                case .island, .hexagon, .fog:
                    guard let locationType = placeholder.location else { fatalError() }
                    
                    let position = DoubleArrayPosition(positionX: itemIndex, positionY: rowIndex)
                    let adjacentHexagons = self.adjacentHexagons(atPosition: position, currentRow: currentRow, gameBoard: gameBoard, generatedBoard: generatedBoard)
                    guard let nextHexagon = randomHexagons[locationType]?.dropFirst(where: { hexagon -> Bool in
                        return distributionRules.allPass({ $0.isHexagonValid(hexagon, withAdjacentHexagons: adjacentHexagons) })
                    }) else {
                        // Stuck without any options while sticking with the no adjacent same resources rule!
                        return Self.generatedBoardPieces()
                    }
                    
                    if case .fog = placeholder {
                        currentRow.append(GameBoardPiece.fog(nextHexagon))
                    } else {
                        currentRow.append(GameBoardPiece.hexagon(nextHexagon))
                    }
                case .port(location: let location):
                    guard let nextPort = randomPortsIterator.next() else { fatalError("Not enough ports for board layout provided") }
                    currentRow.append(GameBoardPiece.port(nextPort, location: location))
                }
            }
            generatedBoard.append(currentRow)
        }
        
        assert(randomPortsIterator.next() == nil, "Too many ports provided for board layout")
        assert(randomHexagons.allPass({ $0.value.count == 0 }), "Too many hexagons provided for board layout")
        
        return generatedBoard
    }
    
    static func adjacentHexagons(atPosition position: DoubleArrayPosition, currentRow: [GameBoardPiece], gameBoard: GameBoard, generatedBoard: [[GameBoardPiece]] ) -> [GameBoardPiece.Hexagon] {
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
        
        return adjacentHexagons
    }
}

//
//  GameBoardPiece.swift
//  Catan
//
//  Created by David Elsonbaty on 8/25/17.
//  Copyright © 2017 David Elsonbaty. All rights reserved.
//

import Foundation

enum GameBoardPiece {
    
    enum Hexagon {
        case theif
        case resource(Resource, value: DiceCombination)
        
        var diceCombination: DiceCombination? {
            switch self {
            case .resource(_, value: let diceCombination): return diceCombination
            default: return nil
            }
        }
        
        var resource: Resource? {
            switch self {
            case .resource(let resource, _): return resource
            default: return nil
            }
        }
    }
    
    var hexagon: Hexagon? {
        switch self {
        case .hexagon(let hexagon): return hexagon
        default: return nil
        }
    }
    
    var isHexagon: Bool {
        return (hexagon != nil)
    }
    
    var isOfHighestProbability: Bool {
        return hexagon?.diceCombination?.probability.isHighest ?? false
    }
    
    case empty
    case hexagon(Hexagon)
    case port(Port, location: Port.Location)
}

extension GameBoardPiece: Equatable {
    
    static func ==(lhs: GameBoardPiece, rhs: GameBoardPiece) -> Bool {
        switch (lhs, rhs) {
        case (.port(let lhsPort, location: _), .port(let rhsPort, location: _)):
            return lhsPort == rhsPort
        case (.hexagon(let lhsHexagon), .hexagon(let rhsHexagon)):
            return lhsHexagon == rhsHexagon
        case (.empty, .empty):
            return true
        default:
            return false
        }
    }
}

extension GameBoardPiece.Hexagon: Equatable {
    static func ==(lhs: GameBoardPiece.Hexagon, rhs: GameBoardPiece.Hexagon) -> Bool {
        switch (lhs, rhs) {
        case (.theif, .theif):
            return true
        case (.resource(let lhsResource, let lhsDiceCombination), .resource(let rhsResource, let rhsDiceCombination)):
            return lhsResource == rhsResource && lhsDiceCombination == rhsDiceCombination
        default:
            return false
        }
    }
}

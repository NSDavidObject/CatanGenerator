//
//  ExtendedClassicGame.swift
//  Catan
//
//  Created by David Elsonbaty on 8/27/17.
//  Copyright © 2017 David Elsonbaty. All rights reserved.
//

import Foundation

struct ExtendedClassicGame: GameDefinition {
    
    static let distructionRules: [GameBoardDistributionRule.Type] = [
        GameBoardDistributionAdjacentResourcesRule.self,
        GameBoardDistributionAdjacentHighProbabilityRule.self
    ]
    
    static let portsList: [(port: Port, count: Int)] = [
        (port: .wild, count: 5),
        (port: .resource(.hay), count: 1),
        (port: .resource(.clay), count: 1),
        (port: .resource(.stone), count: 1),
        (port: .resource(.sheep), count: 2),
        (port: .resource(.wood), count: 1)
    ]
    
    static let resourcesList: [(resource: Resource, count: Int)] = [
        (resource: .hay, count: 6),
        (resource: .clay, count: 5),
        (resource: .stone, count: 5),
        (resource: .sheep, count: 6),
        (resource: .wood, count: 6),
        ]
    
    static let diceCombinationsList: [(combination: DiceCombination, count: Int)] = [
        (combination: .two, count: 2),
        (combination: .three, count: 3),
        (combination: .four, count: 3),
        (combination: .five, count: 3),
        (combination: .six, count: 3),
        (combination: .eight, count: 3),
        (combination: .nine, count: 3),
        (combination: .ten, count: 3),
        (combination: .eleven, count: 3),
        (combination: .twelve, count: 2)
    ]
    
    static let layout: [[GameBoardPiecePlaceholder]] = [
        [
            .port(location: .bottomRight), .empty, .port(location: .bottomLeft), .empty
        ],
        [
            .empty, .hexagon, .hexagon, .hexagon, .port(location: .bottomLeft)
        ],
        [
            .empty, .hexagon, .hexagon, .hexagon, .hexagon, .empty
        ],
        [
            .port(location: .right), .hexagon, .hexagon, .hexagon, .hexagon, .hexagon, .empty
        ],
        [
            .empty, .hexagon, .hexagon, .hexagon, .hexagon, .hexagon, .hexagon, .port(location: .left)
        ],
        [
            .port(location: .right), .hexagon, .hexagon, .hexagon, .hexagon, .hexagon, .empty
        ],
        [
            .port(location: .right), .hexagon, .hexagon, .hexagon, .hexagon, .port(location: .topLeft)
        ],
        [
            .empty, .hexagon, .hexagon, .hexagon, .port(location: .left)
        ],
        [
            .port(location: .topRight), .empty, .port(location: .topLeft), .empty
        ]
    ]
    
}

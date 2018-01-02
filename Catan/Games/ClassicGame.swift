//
//  ClassicGame.swift
//  Catan
//
//  Created by David Elsonbaty on 8/20/17.
//  Copyright © 2017 David Elsonbaty. All rights reserved.
//

import Foundation

struct ClassicGame: GameDefinition {
    
    static let distructionRules: [GameBoardDistributionRule.Type] = [
        GameBoardDistributionAdjacentResourcesRule.self,
        GameBoardDistributionAdjacentHighProbabilityRule.self
    ]
    
    static let portsList: [(port: Port, count: Int)] = [
        (port: .wild, count: 4),
        (port: .resource(.hay), count: 1),
        (port: .resource(.clay), count: 1),
        (port: .resource(.stone), count: 1),
        (port: .resource(.sheep), count: 1),
        (port: .resource(.wood), count: 1)
    ]
    
    static let resourcesList: [(resource: Resource, count: Int)] = [
        (resource: .hay, count: 4),
        (resource: .clay, count: 3),
        (resource: .stone, count: 3),
        (resource: .sheep, count: 4),
        (resource: .wood, count: 4),
        ]
    
    static let diceCombinationsList: [(combination: DiceCombination, count: Int)] = [
        (combination: .two, count: 1),
        (combination: .three, count: 2),
        (combination: .four, count: 2),
        (combination: .five, count: 2),
        (combination: .six, count: 2),
        (combination: .eight, count: 2),
        (combination: .nine, count: 2),
        (combination: .ten, count: 2),
        (combination: .eleven, count: 2),
        (combination: .twelve, count: 1)
    ]
    
    static let layout: [[GameBoardPiecePlaceholder]] = [
        [
            .port(location: .bottomRight), .empty, .port(location: .bottomLeft), .empty
        ],
        [
            .empty, .hexagon, .hexagon, .hexagon, .port(location: .bottomLeft)
        ],
        [
            .port(location: .right), .hexagon, .hexagon, .hexagon, .hexagon, .empty
        ],
        [
            .empty, .hexagon, .hexagon, .hexagon, .hexagon, .hexagon, .port(location: .left)
        ],
        [
            .port(location: .right), .hexagon, .hexagon, .hexagon, .hexagon, .empty
        ],
        [
            .empty, .hexagon, .hexagon, .hexagon, .port(location: .topLeft)
        ],
        [
            .port(location: .topRight), .empty, .port(location: .topLeft), .empty
        ]
    ]
}

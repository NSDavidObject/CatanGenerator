//
//  TheFogIslands3PlayersGameDefinition.swift
//  Catan
//
//  Created by David Elsonbaty on 2/10/18.
//  Copyright © 2018 David Elsonbaty. All rights reserved.
//

import Foundation

struct TheFogIslands3PlayersGameDefinition: GameDefinition {
    
    static let distributionRules: [GameBoardDistributionRule.Type] = [
        GameBoardDistributionAdjacentResourcesRule.self,
        GameBoardDistributionAdjacentHighProbabilityRule.self
    ]
    
    static let portsList: [(port: Port, count: Int)] = [
        (port: .wild, count: 3),
        (port: .resource(.hay), count: 1),
        (port: .resource(.clay), count: 1),
        (port: .resource(.stone), count: 1),
        (port: .resource(.sheep), count: 1),
        (port: .resource(.wood), count: 1)
    ]
    
    static var theifsCount: [LocationType: Int] = [
        .normal: 0,
        .fog: 0
    ]
    
    static var watersCount: [LocationType: Int] = [
        .normal: 0,
        .fog: 2
    ]
    
    static let resources: [LocationType: [Resources]] = [
        .normal: [
            (resource: .hay, count: 2),
            (resource: .clay, count: 2),
            (resource: .stone, count: 2),
            (resource: .sheep, count: 4),
            (resource: .wood, count: 4),
        ],
        .fog: [
            (resource: .hay, count: 2),
            (resource: .clay, count: 2),
            (resource: .stone, count: 2),
            (resource: .sheep, count: 1),
            (resource: .wood, count: 1),
            (resource: .gold, count: 2),
        ]
    ]

    static var diceCombinations: [LocationType : [GameDefinition.DiceCombinations]] = [
        .normal: [
            (combination: .two, count: 0),
            (combination: .three, count: 1),
            (combination: .four, count: 1),
            (combination: .five, count: 2),
            (combination: .six, count: 2),
            (combination: .eight, count: 2),
            (combination: .nine, count: 2),
            (combination: .ten, count: 1),
            (combination: .eleven, count: 2),
            (combination: .twelve, count: 1)
        ],
        .fog: [
            (combination: .two, count: 0),
            (combination: .three, count: 2),
            (combination: .four, count: 1),
            (combination: .five, count: 1),
            (combination: .six, count: 1),
            (combination: .eight, count: 1),
            (combination: .nine, count: 1),
            (combination: .ten, count: 1),
            (combination: .eleven, count: 1),
            (combination: .twelve, count: 1)
        ],
    ]
    
    static let layout: [[GameBoardPiecePlaceholder]] = [
        [
            .empty, .plainWater, .plainWater, .fog, .fog, .empty, .empty
        ],
        [
            .empty, .waterPort(location: .right), .hexagon, .plainWater, .fog, .fog, .empty, .empty
        ],
        [
            .waterPort(location: .right), .hexagon, .hexagon, .plainWater, .fog, .plainWater, .empty
        ],
        [
            .waterPort(location: .bottomRight), .hexagon, .hexagon, .plainWater, .fog, .plainWater, .hexagon, .port(location: .left)
        ],
        [
            .hexagon, .hexagon, .plainWater, .fog, .plainWater, .hexagon, .hexagon
        ],
        [
            .empty, .waterPort(location: .topRight), .plainWater, .fog, .plainWater, .hexagon, .hexagon, .port(location: .topLeft)
        ],
        [
            .empty, .fog, .fog, .plainWater, .hexagon, .hexagon, .port(location: .left)
        ],
        [
            .empty, .empty, .fog, .fog, .plainWater, .waterPort(location: .topLeft), .empty, .empty
        ],
    ]
}

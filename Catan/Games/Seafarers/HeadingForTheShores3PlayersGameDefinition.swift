//
//  HeadingForTheShores3PlayersGameDefinition.swift
//  Catan
//
//  Created by David Elsonbaty on 2/10/18.
//  Copyright © 2018 David Elsonbaty. All rights reserved.
//

import Foundation

struct HeadingForTheShores3PlayersGameDefinition: GameDefinition {
    
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
        .island: 0
    ]
    
    static var watersCount: [LocationType: Int] = [
        .normal: 0,
        .island: 0
    ]
    
    static let resources: [LocationType: [Resources]] = [
        .normal: [
            (resource: .hay, count: 3),
            (resource: .clay, count: 2),
            (resource: .stone, count: 2),
            (resource: .sheep, count: 4),
            (resource: .wood, count: 3),
        ],
        .island: [
            (resource: .hay, count: 1),
            (resource: .clay, count: 2),
            (resource: .stone, count: 2),
            (resource: .sheep, count: 1),
            (resource: .wood, count: 0),
            (resource: .gold, count: 2),
        ]
    ]

    static var diceCombinations: [LocationType : [GameDefinition.DiceCombinations]] = [
        .normal: [
            (combination: .two, count: 1),
            (combination: .three, count: 1),
            (combination: .four, count: 1),
            (combination: .five, count: 2),
            (combination: .six, count: 2),
            (combination: .eight, count: 2),
            (combination: .nine, count: 1),
            (combination: .ten, count: 2),
            (combination: .eleven, count: 2),
            (combination: .twelve, count: 0)
        ],
        .island: [
            (combination: .two, count: 0),
            (combination: .three, count: 1),
            (combination: .four, count: 2),
            (combination: .five, count: 1),
            (combination: .six, count: 0),
            (combination: .eight, count: 1),
            (combination: .nine, count: 1),
            (combination: .ten, count: 1),
            (combination: .eleven, count: 0),
            (combination: .twelve, count: 1),
        ],
    ]
    
    static let layout: [[GameBoardPiecePlaceholder]] = [
        [
            .empty, .empty, .waterPort(location: .bottomLeft), .waterPort(location: .bottomRight), .plainWater, .island, .empty, .empty
        ],
        [
            .port(location: .right), .hexagon, .hexagon, .hexagon, .plainWater, .island, .empty
        ],
        [
            .port(location: .bottomRight), .hexagon, .hexagon, .hexagon, .hexagon, .plainWater, .plainWater, .empty
        ],
        [
            .hexagon, .hexagon, .hexagon, .hexagon, .waterPort(location: .topLeft), .island, .plainWater
        ],
        [
            .port(location: .right), .hexagon, .hexagon, .hexagon, .waterPort(location: .left), .island, .island, .empty
        ],
        [
            .empty, .waterPort(location: .topLeft), .plainWater, .plainWater, .island, .plainWater, .empty
        ],
        [
            .empty, .empty, .island, .island, .plainWater, .plainWater, .empty, .empty
        ],
    ]
}

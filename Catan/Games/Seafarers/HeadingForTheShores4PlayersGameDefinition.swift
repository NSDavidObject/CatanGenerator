//
//  HeadingForTheShores4PlayersGameDefinition.swift
//  Catan
//
//  Created by David Elsonbaty on 2/10/18.
//  Copyright © 2018 David Elsonbaty. All rights reserved.
//

import Foundation

struct HeadingForTheShores4PlayersGameDefinition: GameDefinition {
    
    static let distributionRules: [GameBoardDistributionRule.Type] = [
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
    
    static var theifsCount: [LocationType: Int] = [
        .normal: 1,
        .island: 0
    ]
    
    static var watersCount: [LocationType: Int] = [
        .normal: 0,
        .island: 0
    ]
    
    static let resources: [LocationType: [Resources]] = [
        .normal: [
            (resource: .hay, count: 4),
            (resource: .clay, count: 3),
            (resource: .stone, count: 3),
            (resource: .sheep, count: 4),
            (resource: .wood, count: 4),
        ],
        .island: [
            (resource: .hay, count: 1),
            (resource: .clay, count: 2),
            (resource: .stone, count: 2),
            (resource: .sheep, count: 1),
            (resource: .wood, count: 1),
            (resource: .gold, count: 2),
        ]
    ]

    static var diceCombinations: [LocationType : [GameDefinition.DiceCombinations]] = [
        .normal: [
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
        ],
        .island: [
            (combination: .two, count: 1),
            (combination: .three, count: 1),
            (combination: .four, count: 1),
            (combination: .five, count: 1),
            (combination: .six, count: 1),
            (combination: .eight, count: 1),
            (combination: .nine, count: 1),
            (combination: .ten, count: 1),
            (combination: .eleven, count: 1),
        ],
    ]
    
//    static let layout: [[GameBoardPiecePlaceholder]] = [
//        [
//            .empty, .empty, .waterPort(location: .bottomRight), .plainWater, .waterPort(location: .bottomLeft), .island, .empty, .empty
//        ],
//        [
//            .port(location: .bottomRight), .hexagon, .hexagon, .hexagon, .plainWater, .island, .empty
//        ],
//        [
//            .empty, .hexagon, .hexagon, .hexagon, .hexagon, .waterPort(location: .left), .plainWater, .empty
//        ],
//        [
//            .port(location: .right), .hexagon, .hexagon, .hexagon, .hexagon, .hexagon, .plainWater, .island, .empty
//        ],
//        [
//            .empty, .hexagon, .hexagon, .hexagon, .hexagon, .waterPort(location: .left), .island, .plainWater
//        ],
//        [
//            .port(location: .topRight), .hexagon, .hexagon, .hexagon, .plainWater, .island, .island
//        ],
//        [
//            .empty, .empty, .waterPort(location: .topRight), .plainWater, .waterPort(location: .topLeft), .island, .plainWater, .empty
//        ],
//        [
//           .empty, .empty, .island, .island, .plainWater, .plainWater, .empty
//        ],
//    ]

    static let layout: [[GameBoardPiecePlaceholder]] = [
        [
            .empty, .empty, .empty, .empty, .empty, .empty, .empty, .empty, .empty
        ],
        [
            .empty, .empty, .waterPort(location: .bottomRight), .plainWater, .waterPort(location: .bottomLeft), .island, .empty, .empty, .empty
        ],
        [
            .empty, .port(location: .bottomRight), .hexagon, .hexagon, .hexagon, .plainWater, .island, .empty, .empty
        ],
        [
            .empty, .hexagon, .hexagon, .hexagon, .hexagon, .waterPort(location: .left), .plainWater, .empty, .empty
        ],
        [
            .port(location: .right), .hexagon, .hexagon, .hexagon, .hexagon, .hexagon, .plainWater, .island, .empty
        ],
        [
            .empty, .hexagon, .hexagon, .hexagon, .hexagon, .waterPort(location: .left), .island, .plainWater, .empty
        ],
        [
            .empty, .port(location: .topRight), .hexagon, .hexagon, .hexagon, .plainWater, .island, .island, .empty
        ],
        [
            .empty, .empty, .waterPort(location: .topRight), .plainWater, .waterPort(location: .topLeft), .island, .plainWater, .empty, .empty
        ],
        [
            .empty, .empty, .empty, .island, .island, .plainWater, .plainWater, .empty, .empty
        ],
    ]
}

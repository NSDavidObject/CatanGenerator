//
//  Port.swift
//  Catan
//
//  Created by David Elsonbaty on 8/25/17.
//  Copyright © 2017 David Elsonbaty. All rights reserved.
//

import Foundation

enum Port {
    enum Location {
        case left
        case right
        case topLeft
        case topRight
        case bottomLeft
        case bottomRight
    }
    
    case wild
    case resource(Resource)
}

extension Port: Equatable {
    static func ==(lhs: Port, rhs: Port) -> Bool {
        switch (lhs, rhs) {
        case (.wild, .wild):
            return true
        case (.resource(let lhsResource), .resource(let rhsResource)):
            return lhsResource == rhsResource
        default:
            return false
        }
    }
}

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

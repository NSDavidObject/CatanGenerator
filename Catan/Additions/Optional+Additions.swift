//
//  Optional+Additions.swift
//  Catan
//
//  Created by David Elsonbaty on 8/24/17.
//  Copyright © 2017 David Elsonbaty. All rights reserved.
//

import Foundation

extension Optional {
 
    func apply(_ closure: (Wrapped) -> Void) {
        if case .some(let value) = self {
            closure(value)
        }
    }
}

extension Optional where Wrapped == Bool {
    var value: Bool {
        return self ?? false
    }
}

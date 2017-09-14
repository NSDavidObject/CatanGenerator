//
//  TransformableButton.swift
//  Catan
//
//  Created by David Elsonbaty on 9/13/17.
//  Copyright © 2017 David Elsonbaty. All rights reserved.
//

import UIKit

class TransformableButton: Button {
    
    var shouldTransformOnClick = true
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                alpha = 0.9
                if (shouldTransformOnClick) {
                    transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
                }
            } else {
                alpha = 1.0
                isEnabled = isEnabled
                if (shouldTransformOnClick) {
                    transform = .identity
                }
            }
        }
    }
    
    override func commonInitalization() {
        super.commonInitalization()
        
        adjustsImageWhenHighlighted = false
    }
}

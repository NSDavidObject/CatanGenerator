//
//  Button.swift
//  Catan
//
//  Created by David Elsonbaty on 9/13/17.
//  Copyright © 2017 David Elsonbaty. All rights reserved.
//

import UIKit
import CommonUtilities

class CatanButton: Button {
    
    var clickVolume: Float = 0.1
    var clickSound: SoundType = .none
    var feedbackType: FeedbackType? = .none
    
    override var isEnabled: Bool {
        didSet { self.alpha = isEnabled ? 1 : 0.35 }
    }
    
    // MARK: Initialization
    
    override func commonInitalization() {
        super.commonInitalization()
        addTarget(self, action: #selector(didTouchUpInside), for: .touchUpInside)
    }

    @objc private func didTouchUpInside() {
        playSoundIfNeeded()
        generateFeedbackIfNeeded()
    }
    
    private func generateFeedbackIfNeeded() {
        feedbackType.apply({ FeedbackGenerator.generate(of: $0) }) 
    }
    
    private func playSoundIfNeeded() {
        SoundPlayer.playFrequentSound(of: clickSound, withVolume: clickVolume)
    }
}

//
//  Button.swift
//  Catan
//
//  Created by David Elsonbaty on 9/13/17.
//  Copyright © 2017 David Elsonbaty. All rights reserved.
//

import UIKit

class Button: UIButton {
    
    var clickVolume: Float = 0.1
    var clickSound: SoundType = .none
    var feedbackType: FeedbackType? = .none
    var proportionalCornerRadius: ProportionalCornerRadius?
    convenience init(proportionalCornerRadius: ProportionalCornerRadius) {
        self.init(frame: CGRect.zero)
        self.proportionalCornerRadius = proportionalCornerRadius
    }
    
    override var isEnabled: Bool {
        didSet { self.alpha = isEnabled ? 1 : 0.35 }
    }
    
    // MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInitalization()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInitalization()
    }
    
    func commonInitalization() {
        addTarget(self, action: #selector(didTouchUpInside), for: .touchUpInside)
    }
    
    // MARK: Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        roundCorners()
    }
    
    func roundCorners() {
        if let proportionalCornerRadius = proportionalCornerRadius {
            self.layer.cornerRadius = proportionalCornerRadius.cornerRadius(forSize: self.bounds.size)
        }
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

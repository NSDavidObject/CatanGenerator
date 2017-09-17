//
//  FeedbackGenerator.swift
//  Catan
//
//  Created by David Elsonbaty on 9/16/17.
//  Copyright © 2017 David Elsonbaty. All rights reserved.
//

import UIKit

enum FeedbackType {
    case success
    case warning
    case error
    case selection
}

class FeedbackGenerator {
    
    private static let shared = FeedbackGenerator()
    private init() {}
    
    @available(iOS 10.0, *)
    private lazy var selectionGenerator = UISelectionFeedbackGenerator()
    @available(iOS 10.0, *)
    private lazy var notificationGenerator = UINotificationFeedbackGenerator()
    
    private func generate(of type: FeedbackType) {
        guard #available(iOS 10.0, *) else { fatalError() }
        
        switch type {
        case .success:
            notificationGenerator.notificationOccurred(.success)
        case .warning:
            notificationGenerator.notificationOccurred(.warning)
        case .error:
            notificationGenerator.notificationOccurred(.error)
        case .selection:
            selectionGenerator.selectionChanged()
        }
    }
    
    static func generate(of type: FeedbackType) {
        guard #available(iOS 10.0, *) else { return }
        FeedbackGenerator.shared.generate(of: type)
    }
}

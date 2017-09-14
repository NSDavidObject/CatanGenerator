//
//  SoundPlayer.swift
//  Catan
//
//  Created by David Elsonbaty on 9/13/17.
//  Copyright © 2017 David Elsonbaty. All rights reserved.
//

import UIKit
import AVFoundation

enum SoundType {
    case none
    case click
    case toggle
    
    var isNone: Bool {
        if case .none = self {
            return true
        }
        return false
    }
    var resourceName: String? {
        switch self {
        case .click: return "Click"
        case .toggle: return "Toggle"
        case .none: return nil
        }
    }
    var soundURL: URL? {
        guard let resourceName = resourceName else { return nil }
        let path = Bundle.main.path(forResource: resourceName, ofType: "wav")
        return URL(fileURLWithPath: path!)
    }
}

class SoundPlayer {
    
    private static let shared = SoundPlayer()
    private init() {}
    
    private var players = [SoundType: AVAudioPlayer]()
    private func playSound(of type: SoundType, withVolume volume: Float) {
        guard !type.isNone else { return }
        
        var player = players[type]
        if (player == nil) {
            player = try? AVAudioPlayer(contentsOf: type.soundURL!)
            players[type] = player
        }
        player?.volume = volume
        player?.play()
    }
    
    static func playSound(of type: SoundType, withVolume volume: Float = 1.0) {
        SoundPlayer.shared.playSound(of: type, withVolume: volume)
    }
}

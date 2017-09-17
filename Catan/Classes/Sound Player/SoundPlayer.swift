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

class SoundPlayer: NSObject {
    
    private static let shared = SoundPlayer()
    private override init() {}
    
    private var players = [SoundType: AVAudioPlayer]()
    private var nonreusablePlayers = [AVAudioPlayer]()
    private func playSound(of type: SoundType, withVolume volume: Float, reusingPlayers: Bool = true) {
        guard !type.isNone else { return }
        
        var player: AVAudioPlayer? = reusingPlayers ? players[type] : nil
        if (player == nil) {
            player = try? AVAudioPlayer(contentsOf: type.soundURL!)
            if reusingPlayers {
                players[type] = player
            } else {
                player.apply({
                    player?.delegate = self
                    nonreusablePlayers.append($0)
                })
            }
        }
        
        player?.volume = volume
        player?.prepareToPlay()
        player?.play()
    }
    
    static func playFrequentSound(of type: SoundType, withVolume volume: Float = 1.0) {
        SoundPlayer.shared.playSound(of: type, withVolume: volume, reusingPlayers: false)
    }
    
    static func playSound(of type: SoundType, withVolume volume: Float = 1.0) {
        SoundPlayer.shared.playSound(of: type, withVolume: volume)
    }
}

extension SoundPlayer: AVAudioPlayerDelegate {
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        // delete nonreusable player
        nonreusablePlayers.index(of: player).apply({ nonreusablePlayers.remove(at: $0) })
    }
}

//
//  DeviceInfo.swift
//  Catan
//
//  Created by David Elsonbaty on 1/22/18.
//  Copyright © 2018 David Elsonbaty. All rights reserved.
//

import UIKit

struct DeviceInfo {
    
    static let scale = UIScreen.main.scale
    static let hairline = 1.0 / scale
    
    struct Support {
        static let hapticFeedback: Bool = {
            guard #available(iOS 10.0, *) else { return false }
            guard let value = UIDevice.current.value(forKey: "_feedbackSupportLevel") as? Int else { assert(false); return false }
            return value >= 2
        }()
        static let forceTouch: Bool = {
            guard let compability = UIApplication.shared.keyWindow?.rootViewController?.traitCollection.forceTouchCapability else { return false }
            if case .available = compability {
                return true
            }
            return false
        }()
    }
    
    struct ScreenSize {
        static let width   = UIScreen.main.bounds.size.width
        static let height  = UIScreen.main.bounds.size.height
        static let maxSize = max(ScreenSize.width, ScreenSize.height)
        static let minSize = min(ScreenSize.width, ScreenSize.height)
    }
    
    struct DeviceType {
        static let iPad      = UIDevice.current.userInterfaceIdiom == .pad
        static let iPadPro   = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.maxSize > 1024.0
        
        static let iPhone4   = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxSize < 568.0
        static let iPhone5   = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxSize == 568.0
        static let iPhone6OrGreater  = UIDevice.current.userInterfaceIdiom == .phone && (ScreenSize.maxSize >= 667.0 ||  ScreenSize.maxSize >= 736.0)
    }
}

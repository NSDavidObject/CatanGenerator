//
//  FontType.swift
//  Catan
//
//  Created by David Elsonbaty on 1/22/18.
//  Copyright © 2018 David Elsonbaty. All rights reserved.
//

import UIKit

enum FontType {
    
    static var fontSizes: [CGFloat] {
        if DeviceInfo.DeviceType.iPadPro {
            return [22, 30, 40, 46, 60]
        } else if DeviceInfo.DeviceType.iPad {
            return [18, 22, 30, 42, 50]
        } else if DeviceInfo.DeviceType.iPhone6OrGreater {
            return [16, 20, 28, 30, 42]
        }
        return [14, 18, 22, 24, 28]
    }
    
    enum FontSize: Int {
        case tiny = 0
        case small
        case medium
        case large
        case humongous
        
        static let pointSizes = FontType.fontSizes
        var pointSize: CGFloat {
            return FontSize.pointSizes[rawValue]
        }
    }
    
    case thin(FontSize)
    case light(FontSize)
    case extraLight(FontSize)
    
    var font: UIFont {
        switch self {
        case .thin(let size):
            return UIFont.appFontDefaultThin.withSize(size.pointSize)
        case .light(let size):
            return UIFont.appFontDefaultLight.withSize(size.pointSize)
        case .extraLight(let size):
            return UIFont.appFontDefaultExtraLight.withSize(size.pointSize)
        }
    }
}

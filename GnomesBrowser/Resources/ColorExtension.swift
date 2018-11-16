//
//  ColorExtension.swift
//  Placeholder
//
//  Created by Martin on 11/11/2018.
//  Copyright © 2018 M. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {

    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }

    static var customLightGray : UIColor {
        get { return UIColor(hexString: "#F5F5F5")}
    }

    static var customDarkBlue : UIColor {
        get { return UIColor(hexString: "#25476B") }
    }

    static var primaryColor : UIColor {
        get { return UIColor(hexString: "#007AFF") }
    }
}

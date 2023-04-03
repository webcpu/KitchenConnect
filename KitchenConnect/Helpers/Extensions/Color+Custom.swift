//
//  Color+Custom.swift
//  KitchenConnect
//
//  Created by liang on 01/04/2023.
//

import Foundation
import UIKit
import SwiftUI

// MARK: - Color Extensions

extension Color {
    // Define your custom colors here
    static let customBackground = Color(hex: "#F5F5F5")
    static let customPrimaryCta = Color(hex: "#1C4AB4")
    static let customControlCardIcon = Color(hex: "#1C4AB4")
    static let customCardHeadLine = Color(hex: "#232323")
    static let customCardText = Color(hex: "#707070")
    static let customCardBackground = Color.white
    static let customHeadLineTitle = Color(hex: "#707070")
    static let customH4Headline = Color(hex: "#0A0A0A")
    static let customHeroContent = Color(hex: "#0A0A0A")
}

extension Color {
    /// Convert a Color object to a UIColor object.
    var uiColor: UIColor {
        guard let cgColor = self.cgColor, let components = cgColor.components else {
            return .clear
        }
        let color = UIColor(red: CGFloat(components[0]), green: CGFloat(components[1]), blue: CGFloat(components[2]), alpha: CGFloat(components[3]))
        return color
    }
}

extension Color {
    /// Initialize a Color object from a hexadecimal color string.
    /// - Parameter hex: A hexadecimal color string, with an optional leading "#".
    ///
    init?(hex: String) {
        let red, green, blue: Double

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 6 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    red = Double((hexNumber & 0xff0000) >> 16) / 255.0
                    green = Double((hexNumber & 0x00ff00) >> 8) / 255.0
                    blue = Double(hexNumber & 0x0000ff) / 255.0

                    self.init(red: red, green: green, blue: blue)
                    return
                }
            }
        }

        return nil
    }
}

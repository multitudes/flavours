//
//  Color+Ext.swift
//  worldCupping
//
//  Created by Laurent B on 27/09/2020.
//

import SwiftUI

// This extension will create predefined static colors that can be used in my app like: Color.berry or Color.raisin.
// I use a custom init to create colors from hex values

extension Color {

    public static var gradientStartCoffee: Color {
        return Color(hex: "053C5E")
    }
    
    public static var gradientEndCoffee: Color {
        return Color(hex: "03283F")
    }
}

// This extension allows to create a Color in swiftUI from the hex value
// ex Color(hex: "FA1859") or Color(hex: "F19") and with opacity as hex number at the end
extension Color {
    init(hex: String, opacity a: Double = 1.0) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit like #FFF)
            (r, g, b) = ((int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit like #FFA344)
            (r, g, b) = (int >> 16, int >> 8 & 0xFF, int & 0xFF)
        default:
            (r, g, b) = (255, 255, 255)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: a
        )
    }
}

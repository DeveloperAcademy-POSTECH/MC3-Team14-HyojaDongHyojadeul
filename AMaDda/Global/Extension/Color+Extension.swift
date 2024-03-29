//
//  Color+Extension.swift
//  AMaDda
//
//  Created by Lee Myeonghwan on 2022/07/18.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
           var hexFormatted: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()

           if hexFormatted.hasPrefix("#") {
               hexFormatted = String(hexFormatted.dropFirst())
           }

           assert(hexFormatted.count == 6, "Invalid hex code used.")
           var rgbValue: UInt64 = 0
           Scanner(string: hexFormatted).scanHexInt64(&rgbValue)

           self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
               green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
               blue: CGFloat(rgbValue & 0x0000FF) / 255.0, alpha: alpha)
       }
    static var buttonColor: UIColor {
        return UIColor(hex: "D1B48C")
    }
    static var cardBackgroundColor: UIColor {
        return UIColor(hex: "E0E0E0")
    }
    static var disableDarkButtonColor: UIColor {
        return UIColor(hex: "#3C3C3C")
    }
    static var disableDarkTitleColor: UIColor {
        return UIColor(hex: "#777777")
    }
    static var disableLightButtonColor: UIColor {
        return UIColor(hex: "E0E0E0")
    }
    static var disableLightTitleColor: UIColor {
        return UIColor(hex: "A6A6A6")
    }
    static var onboardingGoalTextColor: UIColor {
        return UIColor(hex: "909090")
    }
}

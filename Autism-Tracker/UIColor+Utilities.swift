//
//  UIColor+Utilities.swift
//  HumansOfSF
//
//  Created by Nicholas Swift on 1/30/17.
//  Copyright © 2017 Jake. All rights reserved.
//

import UIKit

extension UIColor {
    
    /*
     * Converts hex integer into UIColor
     *
     * Usage: UIColor(hex: 0xFFFFFF)
     *
     */
    private convenience init(hex: Int) {
        let components = (
            R: CGFloat((hex >> 16) & 0xff) / 255,
            G: CGFloat((hex >> 08) & 0xff) / 255,
            B: CGFloat((hex >> 00) & 0xff) / 255
        )
        
        self.init(red: components.R, green: components.G, blue: components.B, alpha: 1)
    }
    
    // MARK: Brand Colors
    static let brandBlue = UIColor(hex: 0x4A90E2)
    static let steelBlue = UIColor(hex: 0xA2ABBF)
  
    static let niceGreen = UIColor(hex: 0x3BDE86)
    static let niceBlue = UIColor(hex: 0x60CDFF)
    static let niceRed = UIColor(hex: 0xFF6260)
    static let niceGray = UIColor(hex: 0xF2F3F3)
    
}

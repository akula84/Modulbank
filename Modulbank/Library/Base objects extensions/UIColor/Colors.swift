//
//  Colors.swift
//  PocketNewz
//
//  Created by Alex Kozin on 14.11.2017.
//  Copyright © 2017 el-machine. All rights reserved.
//

import QuartzCore
import UIKit

extension UIColor {
    
    convenience init(red: Int, green: Int, blue: Int, alpha: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: CGFloat(alpha) / 255.0)
    }
    
    convenience init(hex: Int, alpha: Int = 255) {
        self.init(
            red: (hex >> 16) & 0xFF,
            green: (hex >> 8) & 0xFF,
            blue: hex & 0xFF,
            alpha: alpha
        )
    }
    
    
    struct FormField {
        
        static var Border: UIColor {
            return UIColor(hex: 0xCDCDCD)
        }
        
        static var Caption: UIColor {
            return UIColor(hex: 0x666666)
        }
        
    }
    
    struct Underline {
        
        static var Gray: UIColor {
            return UIColor(hex: 0xDEDEDE)
        }
        
        static var Gray2: UIColor {
            return #colorLiteral(red: 0.8392156863, green: 0.8431372549, blue: 0.8431372549, alpha: 1)
        }
        
        static var Red: UIColor {
            return UIColor(hex: 0xDF362A)
        }
    }

    struct Navigation {

        static var ToolbarBackground: UIColor {
            return UIColor(hex: 0x302F30)
        }

    }
    
    struct Common {

        static var Yellow: UIColor {
            return UIColor(hex: 0xFFE02B)
        }
        
        static var Orange: UIColor {
            return UIColor(hex: 0xDC8F00)
        }
    }
    
    struct Home {
        static var BlackTitle: UIColor {
            return UIColor(hex: 0x000000)
        }
        
        static var GrayTitle: UIColor {
            return UIColor(hex: 0x818181)
        }
    }
}

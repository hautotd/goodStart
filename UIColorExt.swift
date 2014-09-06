//
//  UIColorExt.swift
//  App_V0
//
//  Created by Dimitri Hautot on 02/09/2014.
//  Copyright (c) 2014 Dimitri Hautot. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(rgb: UInt) {
        self.init(
            red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgb & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

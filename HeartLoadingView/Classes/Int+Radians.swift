//
//  Int+Radians.swift
//  HeartLoadingView
//
//  Created by Dima Shvets on 01.03.2018.
//

import UIKit

extension Int {
    var degreesToRadians: CGFloat { return CGFloat(self) * .pi / 180 }
}

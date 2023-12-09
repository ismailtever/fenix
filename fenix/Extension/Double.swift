//
//  Double.swift
//  fenix
//
//  Created by Ismail Tever on 3.12.2023.
//

import Foundation

extension Double {
    func formattedString(decimalPlaces: Int = 1) -> String {
        return String(format: "%.\(decimalPlaces)f", self)
    }
}


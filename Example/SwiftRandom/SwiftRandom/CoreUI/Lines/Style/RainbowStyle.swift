//
//  RainbowStyle.swift
//  SwiftRandom
//
//  Created by Vitali Kurlovich on 26.11.25.
//

import SwiftUI

struct RainbowStyle<ID: Hashable>: LineStyle, Hashable where ID: BinaryInteger {
    private let count: Double

    init(count: Int) {
        self.count = Double(count)
    }

    init(_ range: Range<ID>) {
        self.init(count: Int(range.upperBound - range.lowerBound))
    }

    func resolveColor(for id: ID) -> Color {
        let hue = Double(id) / count
        return Color(hue: hue, saturation: 1, brightness: 1)
    }
}

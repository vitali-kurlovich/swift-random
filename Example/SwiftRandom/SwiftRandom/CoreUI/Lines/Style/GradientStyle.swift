//
//  GradientStyle.swift
//  SwiftRandom
//
//  Created by Vitali Kurlovich on 26.11.25.
//

import SwiftUI

struct GradientStyle<ID: Hashable>: LineStyle, Hashable where ID: BinaryInteger {
    private let count: Double
    private let gradient: Gradient

    init(_ gradient: Gradient, count: Int) {
        self.count = Double(count)
        self.gradient = gradient
    }

    init(_ gradient: Gradient, _ range: Range<ID>) {
        self.init(gradient, count: Int(range.upperBound - range.lowerBound))
    }

    func resolveColor(for id: ID) -> Color {
        let position = Double(id) / count
        return gradient.color(at: position)
    }
}

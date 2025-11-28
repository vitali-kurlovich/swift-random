//
//  GradientStyle.swift
//  SwiftRandom
//
//  Created by Vitali Kurlovich on 26.11.25.
//

import SwiftUI

struct GradientStyle<ID: Hashable>: LineStyle, Hashable where ID: BinaryInteger {
    let range: ClosedRange<ID>
    let gradient: Gradient

    init(_ gradient: Gradient, count: Int) {
        self.init(gradient, range: 0 ... ID(count - 1))
    }

    init(_ gradient: Gradient, range: ClosedRange<ID>) {
        self.gradient = gradient
        self.range = range
    }

    func resolveColor(for id: ID) -> Color {
        let offset = id - range.lowerBound
        let position = Double(offset) / Double(range.upperBound - range.lowerBound)

        return gradient.interpolated(at: position)
    }
}

extension GradientStyle {
    init(count: Int) {
        self.init(range: 0 ... ID(count - 1))
    }

    init(range: ClosedRange<ID>) {
        let count = Int(range.upperBound - range.lowerBound)
        self.init(.rainbow(count: count), range: range)
    }
}

#Preview {
    let style = GradientStyle(.init(colors: [.red, .yellow, .green, .blue]), range: 2 ... 5)

    style.resolveColor(for: 2)
    style.resolveColor(for: 3)
    style.resolveColor(for: 4)
    style.resolveColor(for: 5)
}

#Preview {
    let style = GradientStyle(range: 2 ... 15)

    style.resolveColor(for: 2)
    style.resolveColor(for: 3)
    style.resolveColor(for: 4)
    style.resolveColor(for: 5)
    style.resolveColor(for: 6)
    style.resolveColor(for: 7)
    style.resolveColor(for: 8)
    style.resolveColor(for: 9)
    style.resolveColor(for: 10)
    style.resolveColor(for: 11)
    style.resolveColor(for: 12)
    style.resolveColor(for: 13)
    style.resolveColor(for: 14)
    style.resolveColor(for: 15)
}

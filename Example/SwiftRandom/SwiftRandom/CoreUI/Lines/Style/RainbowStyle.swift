//
//  RainbowStyle.swift
//  SwiftRandom
//
//  Created by Vitali Kurlovich on 26.11.25.
//

import SwiftUI

struct RainbowStyle<ID: Hashable>: LineStyle where ID: BinaryInteger {
    private let count: Double

    private let saturation: CGFloat
    private let brightness: CGFloat

    // @Environment(\.colorScheme) var colorScheme: ColorScheme

    private init(count: Double, saturation: CGFloat, brightness: CGFloat) {
        self.count = count
        self.saturation = saturation
        self.brightness = brightness
    }

    func resolveColor(for id: ID) -> Color {
        let hue = Double(id) / count
        return Color(hue: hue, saturation: saturation, brightness: brightness)
    }

    func resolve(in environment: EnvironmentValues) -> Self {
        let colorScheme = environment[keyPath: \.colorScheme]

        switch colorScheme {
        case .dark:
            return .init(count: count, saturation: 0.96, brightness: 0.93)
        default:
            return .init(count: count, saturation: 1, brightness: 1)
        }
    }
}

extension RainbowStyle {
    init(count: Int) {
        self.init(count: .init(count), saturation: 1, brightness: 1)
    }

    init(_ range: Range<ID>) {
        self.init(count: Int(range.upperBound - range.lowerBound))
    }
}

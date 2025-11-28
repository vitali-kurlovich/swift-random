//
//  Gradient+Rainbow.swift
//  SwiftRandom
//
//  Created by Vitali Kurlovich on 28.11.25.
//

import SwiftUI

// Gradient+Pallete

extension Gradient {
    static var systemRainbow: Self {
        let colors: [Color] = [
            .red,
            .orange,
            .yellow,
            .green,
            .mint,

            .cyan,
            .blue,
            .indigo,
            .purple,
        ]

        return .init(colors: colors)
    }

    static func rainbow(count: Int) -> Self {
        #if canImport(UIKit)
            typealias NativeColor = UIColor
        #endif

        #if canImport(AppKit)
            typealias NativeColor = NSColor
        #endif

        let step = 1.0 / CGFloat(count)

        let colors = stride(from: CGFloat.zero, through: 1.0, by: step)
            .map {
                hue in
                let normalize = hue * 0.76

                let color = NativeColor { traits in
                    if traits.userInterfaceStyle == .dark {
                        return .init(hue: normalize, saturation: 0.96, brightness: 0.93, alpha: 1)
                    }

                    return .init(hue: normalize, saturation: 1, brightness: 1, alpha: 1)
                }

                return Color(color)
            }

        return .init(colors: colors)
    }
}

#Preview {
    LinearGradient(gradient: .systemRainbow, startPoint: .leading, endPoint: .trailing)

    LinearGradient(gradient: .rainbow(count: 32), startPoint: .leading, endPoint: .trailing)

    LinearGradient(gradient: .systemRed, startPoint: .leading, endPoint: .trailing)
}

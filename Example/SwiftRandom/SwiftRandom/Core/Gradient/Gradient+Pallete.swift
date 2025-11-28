//
//  Gradient+Pallete.swift
//  SwiftRandom
//
//  Created by Vitali Kurlovich on 28.11.25.
//

import SwiftUI

extension Gradient {
    static let systemRed: Self = system(with: .systemRed)

    static let systemGreen: Self = system(with: .systemGreen)

    static let systemBlue: Self =
        system(with: .systemBlue)

    static let systemOrange: Self =
        system(with: .systemOrange)

    static let systemYellow: Self =
        system(with: .systemYellow)

    static let systemPink: Self =
        system(with: .systemPink)

    static let systemPurple: Self =
        system(with: .systemPurple)

    static let systemTeal: Self =
        system(with: .systemTeal)

    static let systemIndigo: Self =
        system(with: .systemIndigo)

    static let systemBrown: Self =
        system(with: .systemBrown)

    static let systemMint: Self =
        system(with: .systemMint)

    static let systemCyan: Self =
        system(with: .systemCyan)

    static let systemGray: Self =
        system(with: .systemGray)

    static let systemGray2: Self =
        system(with: .systemGray2)

    static let systemGray3: Self =
        system(with: .systemGray3)

    static let systemGray4: Self =
        system(with: .systemGray4)

    static let systemGray5: Self =
        system(with: .systemGray5)

    static let systemGray6: Self =
        system(with: .systemGray6)

    static let tint: Self =
        system(with: .tintColor)
}

private extension Gradient {
    #if canImport(UIKit)
        typealias NativeColor = UIColor
    #endif

    #if canImport(AppKit)
        typealias NativeColor = NSColor
    #endif

    private static func system(with color: NativeColor) -> Self {
        let second = color.withProminence(.quaternary)

        return .init(colors: [Color(color), Color(second)])
    }
}

#Preview {
    VStack(spacing: 2) {
        LinearGradient(gradient: .systemRed, startPoint: .leading, endPoint: .trailing)

        LinearGradient(gradient: .systemGreen, startPoint: .leading, endPoint: .trailing)

        LinearGradient(gradient: .systemBlue, startPoint: .leading, endPoint: .trailing)

        LinearGradient(gradient: .systemOrange, startPoint: .leading, endPoint: .trailing)

        LinearGradient(gradient: .systemYellow, startPoint: .leading, endPoint: .trailing)

        LinearGradient(gradient: .systemPink, startPoint: .leading, endPoint: .trailing)

        LinearGradient(gradient: .systemPurple, startPoint: .leading, endPoint: .trailing)

        LinearGradient(gradient: .systemTeal, startPoint: .leading, endPoint: .trailing)

        LinearGradient(gradient: .systemIndigo, startPoint: .leading, endPoint: .trailing)

        LinearGradient(gradient: .systemBrown, startPoint: .leading, endPoint: .trailing)

        LinearGradient(gradient: .systemMint, startPoint: .leading, endPoint: .trailing)

        LinearGradient(gradient: .systemCyan, startPoint: .leading, endPoint: .trailing)

        LinearGradient(gradient: .systemGray, startPoint: .leading, endPoint: .trailing)

        LinearGradient(gradient: .systemGray2, startPoint: .leading, endPoint: .trailing)

        LinearGradient(gradient: .systemGray3, startPoint: .leading, endPoint: .trailing)

        LinearGradient(gradient: .systemGray4, startPoint: .leading, endPoint: .trailing)

        LinearGradient(gradient: .systemGray5, startPoint: .leading, endPoint: .trailing)

        LinearGradient(gradient: .systemGray6, startPoint: .leading, endPoint: .trailing)

        LinearGradient(gradient: .tint, startPoint: .leading, endPoint: .trailing)
    }
}

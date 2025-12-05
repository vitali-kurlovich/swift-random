//
//  GradientThumbnail+Overlay.swift
//  SwiftRandom
//
//  Created by Vitali Kurlovich on 4.12.25.
//

import SwiftUI

extension GradientThumbnail {
    struct Overlay: View {
        let configuration: Configuration

        init(configuration: Configuration = .default) {
            self.configuration = configuration
        }

        var body: some View {
            if let shadowGradient = configuration.shadowGradient {
                LinearGradient(gradient: shadowGradient,
                               startPoint: .bottom,
                               endPoint: .top)
                    .blendMode(.multiply)
            }

            if let glareGradient = configuration.glareGradient {
                LinearGradient(gradient: glareGradient,
                               startPoint: .top,
                               endPoint: .bottom)
                    .blendMode(.screen)
            }
        }
    }
}

extension GradientThumbnail.Overlay {
    struct Configuration: Hashable {
        var shadowGradient: Gradient?
        var glareGradient: Gradient?
    }
}

extension GradientThumbnail.Overlay.Configuration {
    static let `default`: Self = .init(
        shadowGradient: Gradient(stops: [
            .init(color: .black.opacity(0.1), location: 0),
            .init(color: .white.opacity(0.1), location: 0.12),
        ]),
        glareGradient: Gradient(stops: [
            .init(color: .white.opacity(0.05), location: 0.0),
            .init(color: .white.opacity(0.15), location: 0.3),
            .init(color: .black, location: 0.33),
        ])
    )

    static let none: Self = .init(shadowGradient: nil, glareGradient: nil)
}

// #Preview {
//
// }

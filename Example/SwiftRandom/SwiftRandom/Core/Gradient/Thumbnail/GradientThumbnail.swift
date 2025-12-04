//
//  GradientThumbnail.swift
//  SwiftRandom
//
//  Created by Vitali Kurlovich on 3.12.25.
//

import SwiftUI

extension GradientThumbnail {
    struct Configuration: Hashable {
        var gradient: Gradient
        var background: Backgrond.Configuration
    }
}

struct GradientThumbnail: View {
    let gradient: Gradient
    let background: Backgrond.Configuration
    let overlay: Overlay.Configuration

    @Environment(\.self)
    private var environment: EnvironmentValues

    init(gradient: Gradient,
         background: Backgrond.Configuration = .default,
         overlay: Overlay.Configuration = .default)
    {
        self.gradient = gradient
        self.background = background
        self.overlay = overlay
    }

    var body: some View {
        LinearGradient(gradient: gradient,
                       startPoint: .leading,
                       endPoint: .trailing)
            .background {
                if isBackgroundShow {
                    Backgrond(configuration: background)
                }
            }
            .overlay {
                Overlay()
                    .clipShape(Capsule(style: .continuous))
                    .padding(1)
            }
            .clipShape(Capsule(style: .continuous))
    }
}

private extension GradientThumbnail {
    var isBackgroundShow: Bool {
        gradient.containsTransparent(environment)
    }
}

#Preview {
    Group {
        GradientThumbnail(gradient: .systemRainbow)
        GradientThumbnail(gradient: .systemRed)
    }
    .frame(height: 33)
    .padding()
}

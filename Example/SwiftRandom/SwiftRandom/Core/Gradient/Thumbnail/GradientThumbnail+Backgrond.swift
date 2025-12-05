//
//  GradientThumbnail+Backgrond.swift
//  SwiftRandom
//
//  Created by Vitali Kurlovich on 3.12.25.
//

import SwiftUI

extension GradientThumbnail {
    struct Backgrond: View {
        let configuration: Configuration

        @ScaledMetric
        private var scaleFactor = 1.0

        init(configuration: Configuration = .default) {
            self.configuration = configuration
        }

        var body: some View {
            Checkerboard(itemSize: checkedSize,
                         first: .color(firstColor),
                         second: .color(secondColor))
        }
    }
}

extension GradientThumbnail.Backgrond {
    struct Configuration: Hashable {
        var checkedSize: CGFloat
        var checkedFirstColor: Color
        var checkedSecondColor: Color
    }
}

extension GradientThumbnail.Backgrond.Configuration {
    static var `default`: Self {
        .init(checkedSize: 10,
              checkedFirstColor: .gray,
              checkedSecondColor: Color(uiColor: .systemBackground))
    }
}

#Preview {
    GradientThumbnail.Backgrond()

    GradientThumbnail.Backgrond().frame(height: 32)
}

private extension GradientThumbnail.Backgrond {
    var checkedSize: CGSize {
        .init(width:
            configuration.checkedSize * scaleFactor,
            height: configuration.checkedSize * scaleFactor)
    }

    var firstColor: Color { configuration.checkedFirstColor }
    var secondColor: Color { configuration.checkedSecondColor }
}

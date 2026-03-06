//
//  Created by Vitali Kurlovich on 3.12.25.
//

import SwiftUI
import SwiftUIComponents

extension GradientThumbnail {
    struct Backgrond: View {
        let configuration: Configuration

        init(configuration: Configuration = .default) {
            self.configuration = configuration
        }

        var body: some View {
            Checkerboard(primary: firstColor, secondary: secondColor, .init(size: configuration.checkedSize, dynamicSize: true))
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
              checkedFirstColor: .primary,
              checkedSecondColor: .secondary)
    }
}

#Preview {
    GradientThumbnail.Backgrond()

    GradientThumbnail.Backgrond().frame(height: 32)
}

private extension GradientThumbnail.Backgrond {
    var firstColor: Color { configuration.checkedFirstColor }
    var secondColor: Color { configuration.checkedSecondColor }
}

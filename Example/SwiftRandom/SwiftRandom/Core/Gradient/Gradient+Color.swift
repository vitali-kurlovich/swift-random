//
//  Gradient+Color.swift
//  SwiftRandom
//
//  Created by Vitali Kurlovich on 26.11.25.
//

import SwiftUI

extension Gradient {
    func interpolated(at position: CGFloat) -> Color {
        var iterator = stops.makeIterator()

        guard var last = iterator.next() else {
            return .clear
        }

        while last.location <= position {
            guard let stop = iterator.next() else {
                return last.color
            }

            if stop.location >= position {
                return color(at: position, last: last, next: stop)
            }

            last = stop
        }

        return last.color
    }
}

extension Gradient {
    func containsTransparent(_ environment: EnvironmentValues) -> Bool {
        stops.contains {
            $0.color.resolve(in: environment).opacity < 1.0
        }
    }
}

private extension Gradient {
    func color(at position: CGFloat, last: Stop, next: Stop) -> Color {
        if last.location == next.location {
            if position <= last.location {
                return last.color
            } else {
                return next.color
            }
        }

        let distance = next.location - last.location
        let offset = position - last.location

        var fraction = offset / distance

        fraction = max(0, fraction)
        fraction = min(1, fraction)

        return last.color.mix(with: next.color, by: fraction)
    }
}

#Preview {
    let gradient = Gradient(colors: [.red, .yellow])

    gradient.interpolated(at: 0)
    gradient.interpolated(at: 0.5)
    gradient.interpolated(at: 1)
}

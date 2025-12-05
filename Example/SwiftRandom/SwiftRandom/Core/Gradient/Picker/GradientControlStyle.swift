//
//  GradientControlStyle.swift
//  SwiftRandom
//
//  Created by Vitali Kurlovich on 4.12.25.
//

import SwiftUI

extension GradientControlStyle {
    struct Chevron: View {
        @Binding
        var isExpanded: Bool

        init(isExpanded: Binding<Bool>) {
            _isExpanded = isExpanded
        }

        var body: some View {
            Color.clear
                .background(.ultraThinMaterial)
                .overlay {
                    Image(systemName: "chevron.forward")
                        .rotationEffect(.degrees(isExpanded ? 90 : 0))

                }.clipShape(Circle())
        }
    }
}

struct GradientControlStyle: ButtonStyle {
    let gradient: Gradient

    @Binding
    var showButton: Bool

    @Binding
    var isExpanded: Bool

    @Environment(\.isEnabled)
    private var isEnabled: Bool

    @ScaledMetric
    private var scaledHeight = 29.0

    @ScaledMetric
    private var scaledPadding = 3

    func makeBody(configuration: Configuration) -> some View {
        VStack {
            HStack(spacing: scaledPadding) {
                GradientThumbnail(gradient: gradient)
                    .frame(height: scaledHeight)
                    .grayscale(isEnabled ? 0 : 0.6)
                    .opacity(isEnabled ? 1 : 0.33)
                    .opacity(configuration.isPressed ? 0.88 : 1)

                if showButton {
                    Chevron(isExpanded: $isExpanded)
                        .frame(width: scaledHeight,
                               height: scaledHeight)
                }
            }
            .shadow(radius: isExpanded ? 2 : 1,
                    y: isExpanded ? 2 : 1)

            if isExpanded {
                Text("Row 1")
                Text("Row 2")
            }
        }
        .padding(scaledPadding)
        .background {
            Backgrond(gradient: gradient)
                .clipShape(RoundedRectangle(cornerSize: .init(width: cornerRadius, height: cornerRadius), style: .continuous))
                .shadow(radius: shadowRadius(configuration),
                        y: shadowOffset(configuration))
        }
    }

    private var cornerRadius: CGFloat {
        (scaledHeight + 2 * scaledPadding) / 2
    }

    struct Backgrond: View {
        let gradient: Gradient
        let color: Color

        @Environment(\.isEnabled)
        private var isEnabled: Bool

        init(gradient: Gradient,
             color: Color = Color(uiColor: .secondarySystemBackground))
        {
            self.gradient = gradient
            self.color = color
        }

        var body: some View {
            color.overlay {
                LinearGradient(gradient: gradient,
                               startPoint: .leading,
                               endPoint: .trailing)
                    .opacity(isEnabled ? 0.1 : 0.05)
                    .brightness(0.33)
                    .contrast(1.1)
            }
        }
    }
}

private extension GradientControlStyle {
    func shadowRadius(_ configuration: Configuration) -> CGFloat {
        var radius: CGFloat = isEnabled ? 2 : 1
        if configuration.isPressed {
            radius = 1
        }
        return radius
    }

    func shadowOffset(_ configuration: Configuration) -> CGFloat {
        var offset: CGFloat = isEnabled ? 2 : 1
        if configuration.isPressed {
            offset = 1
        }
        return offset
    }
}

#Preview {
    @Previewable @State var showButton = true
    @Previewable @State var isExpanded = true
    Spacer()
    Button("") {
        withAnimation {
            isExpanded.toggle()
        }
    }.buttonStyle(
        GradientControlStyle(
            gradient: .systemRainbow,
            showButton: $showButton,
            isExpanded: $isExpanded
        ))

    Button("") {
        withAnimation {
            isExpanded.toggle()
        }
    }.buttonStyle(
        GradientControlStyle(
            gradient: .systemRed,
            showButton: $showButton,
            isExpanded: $isExpanded
        ))
    // .frame(height: 36)

    GradientControlStyle.Chevron(isExpanded: $isExpanded)
        .frame(width: 33)

    Spacer()
    Button("Expand") {
        withAnimation {
            isExpanded.toggle()
        }
    }
}

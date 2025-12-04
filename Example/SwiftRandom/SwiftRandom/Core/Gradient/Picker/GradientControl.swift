//
//  GradientControl.swift
//  SwiftRandom
//
//  Created by Vitali Kurlovich on 3.12.25.
//

import SwiftUI

struct GradientControlStyle: ButtonStyle {
    let gradient: Gradient

    @Binding
    var showButton: Bool

    @Environment(\.isEnabled)
    private var isEnabled: Bool

    func makeBody(configuration: Configuration) -> some View {
        HStack(spacing: 1) {
            GradientThumbnail(gradient: gradient)
                .grayscale(isEnabled ? 0 : 0.6)
                .opacity(isEnabled ? 1 : 0.33)
                // .scaleEffect(configuration.isPressed ? 0.999 : 1)
                .opacity(configuration.isPressed ? 0.88 : 1)
            if showButton {
                Button {} label: {
                    Image(systemName: "chevron.right")
                        .rotationEffect(.degrees(90))
                }
                .labelStyle(.iconOnly)
                .buttonBorderShape(.circle)
                .buttonStyle(.glass)
            }
        }
        .padding(3)
        .background {
            Backgrond(gradient: gradient)
                .clipShape(Capsule(style: .continuous))
                .shadow(radius: isEnabled ? 2 : 1, y: isEnabled ? 2 : 1)
        }
    }

    struct Backgrond: View {
        let gradient: Gradient
        let color: Color

        @Environment(\.isEnabled)
        private var isEnabled: Bool

        init(gradient: Gradient, color: Color = .white) {
            self.gradient = gradient
            self.color = color
        }

        var body: some View {
            color.overlay {
                LinearGradient(gradient: gradient,
                               startPoint: .leading,
                               endPoint: .trailing)
                    .opacity(isEnabled ? 0.4 : 0.2)
                    // .grayscale(0.5)
                    .brightness(0.33)
                    .contrast(1.1)
            }
        }
    }
}

struct GradientControl: View {
    let gradient: Gradient

    @Binding
    var showButton: Bool

    init(gradient: Gradient, showButton: Binding<Bool>) {
        self.gradient = gradient
        _showButton = showButton
    }

    @Environment(\.isEnabled)
    private var isEnabled: Bool

    var body: some View {
        Button("") {}.buttonStyle(GradientControlStyle(gradient: gradient, showButton: $showButton))
    }
}

extension GradientControl {
    init(gradient: Gradient, showButton: Bool = true) {
        let showButton: Binding<Bool> = .init {
            showButton
        } set: { _ in
        }

        self.init(gradient: gradient, showButton: showButton)
    }
}

extension GradientControl {
    struct Backgrond: View {
        let gradient: Gradient
        let color: Color

        @Environment(\.isEnabled)
        private var isEnabled: Bool

        init(gradient: Gradient, color: Color = .white) {
            self.gradient = gradient
            self.color = color
        }

        var body: some View {
            color.overlay {
                LinearGradient(gradient: gradient,
                               startPoint: .leading,
                               endPoint: .trailing)
                    .opacity(isEnabled ? 0.4 : 0.2)
                    // .grayscale(0.5)
                    .brightness(0.33)
                    .contrast(1.1)
            }
        }
    }
}

#Preview {
    @Previewable @State var showButton = true

    Group {
        GradientControl(gradient: .systemRainbow, showButton: $showButton)
            .frame(height: 36)
        GradientControl(gradient: .systemRainbow, showButton: $showButton).disabled(true)

        if showButton {
            GradientControl(gradient: .systemRed, showButton: showButton)
        } else {
            GradientControl(gradient: .systemRed, showButton: showButton)
        }

        GradientControl(gradient: .systemRed).disabled(true)

        Spacer()
    }
    // .frame(height: 36)
    .padding()

    Button("Toogle") {
        withAnimation(.easeInOut.speed(2.0)) {
            showButton.toggle()
        }
    }
}

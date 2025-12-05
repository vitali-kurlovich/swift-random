//
//  GradientControl.swift
//  SwiftRandom
//
//  Created by Vitali Kurlovich on 3.12.25.
//

import SwiftUI

extension GradientControl {
    enum Size {
        case small
        case medium
    }

    enum Style {
        case mini
    }
}

struct GradientControl: View {
    let gradient: Gradient

    @Binding
    var showButton: Bool

    @Binding
    var isExpanded: Bool

    init(gradient: Gradient, showButton: Binding<Bool>, isExpanded: Binding<Bool>) {
        self.gradient = gradient
        _showButton = showButton
        _isExpanded = isExpanded
    }

    @Environment(\.isEnabled)
    private var isEnabled: Bool

    var body: some View {
        Button("") {
            withAnimation(.easeInOut(duration: 0.2)) {
                isExpanded.toggle()
            }

        }.buttonStyle(
            GradientControlStyle(gradient: gradient,
                                 showButton: $showButton,
                                 isExpanded: $isExpanded))
    }
}

extension GradientControl {
    init(gradient: Gradient, showButton: Bool = true, isExpanded: Bool = false) {
        let showButton: Binding<Bool> = .init {
            showButton
        } set: { _ in
        }

        let isExpanded: Binding<Bool> = .init {
            isExpanded
        } set: { _ in
        }

        self.init(gradient: gradient, showButton: showButton, isExpanded: isExpanded)
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
                    // .opacity(isEnabled ? 0.0 : 0.1)
                    // .grayscale(0.5)
                    .brightness(0.33)
                    .contrast(1.1)
            }
        }
    }
}

#Preview {
    @Previewable @State var showButton = true

    @Previewable @State var isExpanded = false

    Group {
        GradientControl(gradient: .systemRainbow, showButton: $showButton, isExpanded: $isExpanded)
        // .frame(height: 36)
        GradientControl(gradient: .systemRainbow, showButton: $showButton, isExpanded: $isExpanded).disabled(true)

        GradientControl(gradient: .systemRed, showButton: $showButton, isExpanded: $isExpanded)

        Spacer()
    }
    // .frame(height: 36)
    .padding()
    HStack {
        Button("Toogle") {
            withAnimation(.easeInOut.speed(2.0)) {
                showButton.toggle()
            }
        }

        Button("Expand") {
            withAnimation(.easeInOut.speed(2.0)) {
                isExpanded.toggle()
            }
        }
    }
}

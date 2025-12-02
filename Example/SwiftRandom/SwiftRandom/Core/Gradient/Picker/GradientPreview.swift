//
//  GradientPreview.swift
//  SwiftRandom
//
//  Created by Vitali Kurlovich on 29.11.25.
//

import SwiftUI

struct CapsuleView {
    let maxCornerRadius: CGFloat?
}

struct GradientCapsule: View {
    let gradient: Gradient
    let maxCornerRadius: CGFloat?

    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size

            let radius = min(size.width, size.height) / 2

            let cornerRadius = min(maxCornerRadius ?? .infinity, radius)

            LinearGradient(gradient: gradient,
                           startPoint: .leading,
                           endPoint: .trailing)
                .cornerRadius(cornerRadius)
        }
    }
}

#Preview {
    GradientCapsule(gradient: .systemRainbow, maxCornerRadius: 32)
        .shadow(radius: 3, y: 3)
        .frame(height: 33)
        .padding()
}

struct GradientPreview: View {
    @Environment(\.isEnabled)
    private var isEnabled: Bool

    // @Environment(\.is)

    let gradient: Gradient

    var body: some View {
        ZStack(alignment: .trailing) {
            ZStack {
                Capsule()
                    .fill(LinearGradient(gradient: gradient, startPoint: .leading, endPoint: .trailing))
                    .opacity(isEnabled ? 0.4 : 0.2)
                    // .grayscale(0.5)
                    .brightness(0.33)
                    .contrast(1.1)
                // .grayscale(isEnabled ? 0 :  0.7)

                // Capsule()
                //    .fill(Color.clear)
                //  Color.clear.background(.ultraThinMaterial)

                HStack(spacing: 0) { // (alignment: .trailing) {

                    Capsule()
                        // .stroke(lineWidth: 3)
                        .fill(LinearGradient(gradient: gradient, startPoint: .leading, endPoint: .trailing))
                        .opacity(isEnabled ? 1 : 0.1)
                    // .grayscale(isEnabled ? 0 :  0.3)
                    // .cornerRadius(14)

                    //  .shadow(radius: 0, y: 1)
//                        .overlay {
//                            Capsule().fill(LinearGradient(gradient: gradient, startPoint: .leading, endPoint: .trailing))
//                        }

                    Button {} label: {
                        // Label("Copy", systemImage: "document.on.document")
                        Image(systemName: "chevron.right")
                            .rotationEffect(.degrees(0))
                    }
                    .labelStyle(.iconOnly)
                    .buttonBorderShape(.circle)
                    .buttonStyle(.glass)
                    // .buttonRepeatBehavior(.)
                    // .border(Color.red)
                    // .glassEffect()

//
//                        Circle()
//                            .fill(Color.clear)
//                            .frame(width: 32,height: 32)
//                            .glassEffect(.clear.interactive())
//                            .padding(2)
//
//                        Image(systemName: "sparkles.2")
//                            .renderingMode(.template)
//                            .foregroundColor(.accentColor)
                }
                .padding(4)

                // .blur(radius: 3)
                // .grayscale(0.7)
            }
            .cornerRadius(20)
            // .shadow(radius: isEnabled ? 1 : 0, y: isEnabled ? 2 : 1)

            //  .background(.ultraThickMaterial)
            // .opacity(0.3)
            // .glassEffect( .clear ).opacity(0.3)
        }
        .padding()
        // .frame(height: 33)

        // .shadow(radius: 3, y: 2)
    }
}

#Preview {
    @Previewable @State var topExpanded = true

    Group {
        GradientPreview(gradient: .systemRainbow)

        GradientPreview(gradient: .systemRainbow).disabled(true)

        GradientPreview(gradient: .systemRed)

        GradientPreview(gradient: .systemRed).disabled(true)

        GradientPreview(gradient: .systemIndigo)

        GradientPreview(gradient: .systemIndigo).disabled(true)
    }
    // c.padding()
}

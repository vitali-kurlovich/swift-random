//
//  CheckedView.swift
//  SwiftRandom
//
//  Created by Vitali Kurlovich on 30.11.25.
//

import SwiftUI

struct CheckedView: View {
    let itemSize: CGSize
    let center: UnitPoint

    let first: GraphicsContext.Shading?
    let second: GraphicsContext.Shading?

    init(itemSize: CGSize,
         center: UnitPoint = .center,
         first: GraphicsContext.Shading? = .foreground,
         second: GraphicsContext.Shading? = .backdrop)
    {
        self.itemSize = itemSize
        self.center = center

        self.first = first
        self.second = second
    }

    var body: some View {
        Canvas { context, size in
            func fillWith(_ center: CGPoint, shading: GraphicsContext.Shading) {
                var center = center

                var resolver = CheckedResolver(itemSize: itemSize,
                                               center: center,
                                               bounds: .init(origin: .zero, size: size))

                fill(context, shading: shading, drawRect: resolver.drawRect)

                center.x += itemSize.width
                center.y += itemSize.height

                resolver = CheckedResolver(itemSize: itemSize,
                                           center: center,
                                           bounds: .init(origin: .zero, size: size))

                fill(context, shading: shading, drawRect: resolver.drawRect)
            }

            var center = CGPoint(x: center.x * size.width,
                                 y: center.y * size.height)

            if let first {
                fillWith(center, shading: first)
            }

            center.x += itemSize.width
            if let second {
                fillWith(center, shading: second)
            }
        }
    }
}

private extension CheckedView {
    func fill(_ context: GraphicsContext, shading: GraphicsContext.Shading, drawRect: CGRect) {
        var context = context

        let rect = CGRect(origin: .zero, size: itemSize)
        let rectPath = Path(roundedRect: rect, cornerRadius: 0)

        var transform = CGAffineTransform.identity

        let x_step = 2 * itemSize.width
        let y_step = 2 * itemSize.height

        for y in stride(from: drawRect.minY, through: drawRect.maxY, by: y_step) {
            transform.ty = y

            for x in stride(from: drawRect.minX, through: drawRect.maxX, by: x_step) {
                transform.tx = x
                context.transform = transform
                context.fill(rectPath, with: shading)
            }
        }
    }
}

private struct CheckedResolver {
    let itemSize: CGSize
    let center: CGPoint
    let bounds: CGRect

    var drawRect: CGRect {
        let size = CGSize(width: 2 * itemSize.width, height: 2 * itemSize.height)

        let leftCount = -((center.x - bounds.minX) / (size.width)).rounded(.up)
        let rightCount = ((bounds.maxX - center.x) / (size.width)).rounded(.down)

        let minX = center.x + size.width * leftCount
        let maxX = center.x + size.width * rightCount

        let topCount = -((center.y - bounds.minY) / (size.height)).rounded(.up)
        let bottomCount = ((bounds.maxY - center.y) / (size.height)).rounded(.down)

        let minY = center.y + size.height * topCount
        let maxY = center.y + size.height * bottomCount

        return .init(x: minX, y: minY,
                     width: maxX - minX, height: maxY - minY)
    }
}

#Preview {
    CheckedView(itemSize: .init(width: 20, height: 20),
                 center: .center,
                 first: .style(Color.blue.gradient),
                 second: .style(Color.red.gradient))
        .padding()

    CheckedView(itemSize: .init(width: 16, height: 16), center: .topLeading,
                 first: nil,
                 second: .style(Color.red.gradient))
        .padding()

    CheckedView(itemSize: .init(width: 12, height: 12), center: .bottomTrailing,
                 first: .style(Color.blue),
                 second: nil)
        .padding()
}

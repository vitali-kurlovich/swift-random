//
//  VerlicalLinesLayout.swift
//  SwiftRandom
//
//  Created by Vitali Kurlovich on 26.11.25.
//

import SwiftUI

struct VerlicalLinesLayout: Layout {
    let spacing: CGFloat
    let barMinWidth: CGFloat?
    let alignment: HorizontalAlignment

    init(spacing: CGFloat = 1, barMinWidth: CGFloat? = 1, alignment: HorizontalAlignment = .center) {
        self.spacing = spacing
        self.barMinWidth = barMinWidth
        self.alignment = alignment
    }

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache _: inout ()) -> CGSize {
        let count = subviews.count

        let spacingCount = max(0, count - 1)

        let barMinWidth = self.barMinWidth ?? 1

        let minWidth = CGFloat(count) * barMinWidth + CGFloat(spacingCount) * spacing

        let height = proposal.height ?? 21

        return CGSize(width: proposal.width ?? minWidth, height: proposal.height ?? height)
    }

    func placeSubviews(in bounds: CGRect, proposal _: ProposedViewSize, subviews: Subviews, cache _: inout ()) {
        let barMinWidth = self.barMinWidth ?? 1

        let count = subviews.count
        let spacingCount = max(0, count - 1)

        let fullSpacingWidth = CGFloat(spacingCount) * spacing

        let fillWidth = bounds.width - fullSpacingWidth

        var itemWidth = (fillWidth / CGFloat(count)).rounded(.down)

        itemWidth = max(itemWidth, barMinWidth)

        let fullWidth = itemWidth * CGFloat(count) + fullSpacingWidth

        var placePoint: CGPoint
        let y = bounds.minY

        switch alignment {
        case .leading, .listRowSeparatorLeading:
            let x = bounds.minX // min(bounds.minX, bounds.maxX - fullWidth)
            placePoint = CGPoint(x: x, y: y)

        case .trailing, .listRowSeparatorTrailing:
            let x = bounds.maxX - fullWidth
            placePoint = CGPoint(x: x, y: y)

        default:
            let x = bounds.midX - fullWidth / 2
            placePoint = CGPoint(x: x, y: y)
        }

        let size = ProposedViewSize(width: itemWidth, height: bounds.height)
        let step = itemWidth + spacing

        for view in subviews {
            view.place(at: placePoint, anchor: .topLeading, proposal: size)

            placePoint.x += step
        }
    }
}

#Preview {
    VerlicalLinesLayout(spacing: 1, barMinWidth: 16, alignment: .leading) {
        ForEach(0 ..< 5
        ) { _ in
            Color.green
        }
    }
    .border(Color.blue)
    .frame(width: 120, height: 44)
    .border(Color.red)
}

//
//  VerlicalLinesLayout.swift
//  SwiftRandom
//
//  Created by Vitali Kurlovich on 26.11.25.
//

import SwiftUI

struct VerlicalLinesLayout: Layout {
    let spacing: CGFloat?
    let lineMinWidth: CGFloat?
    let alignment: HorizontalAlignment

    @Environment(\.displayScale)
    private var displayScale: CGFloat

    @Environment(\.pixelLength)
    private var pixelLength: CGFloat

    init(spacing: CGFloat? = nil, barMinWidth: CGFloat? = 1, alignment: HorizontalAlignment = .center) {
        self.spacing = spacing
        lineMinWidth = barMinWidth
        self.alignment = alignment
    }

    var spacingWidth: CGFloat {
        spacing ?? pixelLength
    }

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache _: inout ()) -> CGSize {
        let count = subviews.count

        let spacingCount = max(0, count - 1)

        let barMinWidth = lineMinWidth ?? 1

        let minWidth = CGFloat(count) * barMinWidth + CGFloat(spacingCount) * spacingWidth

        let height = proposal.height ?? 21

        return CGSize(width: proposal.width ?? minWidth, height: proposal.height ?? height)
    }

    func placeSubviews(in bounds: CGRect, proposal _: ProposedViewSize, subviews: Subviews, cache _: inout ()) {
        let barMinWidth = lineMinWidth ?? 1

        let count = subviews.count
        let spacingCount = max(0, count - 1)

        let fullSpacingWidth = CGFloat(spacingCount) * spacingWidth

        let fillWidth = bounds.width - fullSpacingWidth

        var itemWidth = ((fillWidth * displayScale) / CGFloat(count)).rounded(.down) / displayScale

        itemWidth = max(itemWidth, barMinWidth)

        let fullWidth = itemWidth * CGFloat(count) + fullSpacingWidth

        var placePoint: CGPoint
        let y = bounds.minY

        switch alignment {
        case .leading, .listRowSeparatorLeading:
            let x = bounds.minX
            placePoint = CGPoint(x: x, y: y)

        case .trailing, .listRowSeparatorTrailing:
            let x = bounds.maxX - fullWidth
            placePoint = CGPoint(x: x, y: y)

        default:
            let x = bounds.midX - fullWidth / 2
            placePoint = CGPoint(x: x, y: y)
        }

        let size = ProposedViewSize(width: itemWidth, height: bounds.height)
        let step = itemWidth + spacingWidth

        for view in subviews {
            view.place(at: placePoint, anchor: .topLeading, proposal: size)

            placePoint.x += step
        }
    }
}

#Preview {
    VerlicalLinesLayout(spacing: nil, barMinWidth: 16, alignment: .leading) {
        ForEach(0 ..< 5
        ) { _ in
            Color.green
        }
    }
    .border(Color.blue)
    .frame(width: 120, height: 44)
    .border(Color.red)
}

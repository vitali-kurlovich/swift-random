//
//  Pivot.swift
//  SwiftRandom
//
//  Created by Vitali Kurlovich on 2.12.25.
//

import SwiftUI

struct Pivot: View {
    let axisSize: CGSize
    let lineWidth: CGFloat
    let xAxisColor: Color
    let yAxisColor: Color

    init(axisSize: CGSize = .init(width: 12, height: 12),
         lineWidth: CGFloat = 2,
         xAxisColor: Color = .red,
         yAxisColor: Color = .blue)
    {
        self.axisSize = axisSize
        self.lineWidth = lineWidth

        self.xAxisColor = xAxisColor
        self.yAxisColor = yAxisColor
    }

    var xAxis: Path {
        var xAxis = Path()
        xAxis.move(to: .zero)
        xAxis.addLine(to: CGPoint(x: axisSize.width, y: 0))
        return xAxis
    }

    var yAxis: Path {
        var yAxis = Path()
        yAxis.move(to: .zero)
        yAxis.addLine(to: CGPoint(x: 0, y: axisSize.height))
        return yAxis
    }

    var body: some View {
        xAxis.stroke(xAxisColor, lineWidth: lineWidth)
        yAxis.stroke(yAxisColor, lineWidth: lineWidth)
    }
}

extension Pivot {
    func pivotCenter(_ center: CGPoint) -> some View {
        offset(x: center.x, y: center.y)
    }

    func pivotCenter(_ center: UnitPoint) -> some View {
        GeometryReader { proxy in
            let frame = proxy.frame(in: .local)

            let center = CGPoint(x: center.x * frame.size.width + frame.minX,
                                 y: center.y * frame.size.height + frame.minY)

            self.offset(x: center.x, y: center.y)
        }

        // offset(x: center.x, y: center.y)
    }
}

//
//  VerlicalLines.swift
//  SwiftRandom
//
//  Created by Vitali Kurlovich on 26.11.25.
//

import SwiftUI

struct VerlicalLinesConfiguration: Equatable {
    let spacing: CGFloat
    let lineMinWidth: CGFloat?
    let alignment: HorizontalAlignment

    static var `default`: Self {
        .init(spacing: 1, lineMinWidth: 4, alignment: .center)
    }
}

struct VerlicalLines<
    ID,
    Data: RandomAccessCollection,
    Style: LineStyle
>: View
    where Data: RandomAccessCollection, ID: Hashable, ID == Style.ID
{
   // @Binding
   // private  var data: Data
    
    
    private let data: Data
    private let keyPath: KeyPath<Data.Element, ID>

    private let configuration: VerlicalLinesConfiguration

    private let style: Style

    var body: some View {
        VerlicalLinesLayout(spacing: spacing, barMinWidth: lineMinWidth, alignment: alignment) {
            ForEach(data, id: keyPath) { item in
                let id = item[keyPath: self.keyPath]

                Line(color: style.resolveColor(for: id))
                    .id(id)
            }
        }
    }
}

extension VerlicalLines {
    init(_ data: Data,
         id: KeyPath<Data.Element, ID>,
         configuration: VerlicalLinesConfiguration = .default,
         style: Style)
    {
        self.data = data
        keyPath = id
        self.configuration = configuration
        self.style = style
    }

    init(_ data: Data,
         configuration: VerlicalLinesConfiguration = .default,
         style: Style)
        where Data.Element: Identifiable, Data.Element.ID == ID
    {
        self.init(data, id: \.id, configuration: configuration, style: style)
    }

    init(_ data: Data,
         configuration: VerlicalLinesConfiguration = .default,
         style: Style)
        where Data.Element: Hashable, Data.Element == ID
    {
        self.init(data, id: \.self, configuration: configuration, style: style)
    }
}

extension VerlicalLines where Style == GradientStyle<ID> {
    init(_ data: Data,
         id: KeyPath<Data.Element, ID>,
         configuration: VerlicalLinesConfiguration = .default,
         gradient: Gradient)
    {
        let style: Style = .init(gradient, count: data.count)
        self.init(data, id: id, configuration: configuration, style: style)
    }

    init(_ data: Data,
         configuration: VerlicalLinesConfiguration = .default,
         gradient: Gradient)
        where Data.Element: Identifiable, Data.Element.ID == ID
    {
        let style: Style = .init(gradient, count: data.count)
        self.init(data, configuration: configuration, style: style)
    }

    init(_ data: Data,
         configuration: VerlicalLinesConfiguration = .default,
         gradient: Gradient)
        where Data.Element: Hashable, Data.Element == ID
    {
        let style: Style = .init(gradient, count: data.count)
        self.init(data, configuration: configuration, style: style)
    }
}

extension VerlicalLines where Style == RainbowStyle<ID> {
    init(_ data: Data, id: KeyPath<Data.Element, ID>, configuration: VerlicalLinesConfiguration = .default) {
        let style = RainbowStyle<ID>(count: data.count)
        self.init(data, id: id, configuration: configuration, style: style)
    }

    init(_ data: Data, configuration: VerlicalLinesConfiguration = .default) where Data.Element: Identifiable, Data.Element.ID == ID {
        let style = RainbowStyle<ID>(count: data.count)
        self.init(data, configuration: configuration, style: style)
    }

    init(_ data: Data, configuration: VerlicalLinesConfiguration = .default) where Data.Element: Hashable, Data.Element == ID {
        let style = RainbowStyle<ID>(count: data.count)
        self.init(data, id: \.self, configuration: configuration, style: style)
    }
}

private extension VerlicalLines {
    var spacing: CGFloat { configuration.spacing }
    var lineMinWidth: CGFloat? { configuration.lineMinWidth }
    var alignment: HorizontalAlignment { configuration.alignment }
}

private extension VerlicalLines {
    struct Line: View, Hashable {
        let color: Color

        var body: some View {
            color
        }
    }
}

#Preview {
    let gradient = Gradient(colors: [.green, .red, .blue])

    VStack {
        VerlicalLines(0 ..< 32)
        VerlicalLines((0 ..< 64).shuffled())

        Rectangle()
            .fill(LinearGradient(gradient: gradient, startPoint: .leading, endPoint: .trailing))
            .stroke(.foreground, lineWidth: 1)
            .frame(height: 12)
        VerlicalLines(0 ..< 32, gradient: gradient)

        VerlicalLines((0 ..< 64).shuffled(), gradient: gradient)
    }
}

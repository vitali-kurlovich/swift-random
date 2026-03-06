//
//  Created by Vitali Kurlovich on 26.11.25.
//

import SwiftUI
import SwiftUIComponents

struct VerlicalLinesConfiguration: Equatable {
    let spacing: CGFloat?
    let lineMinWidth: CGFloat?
    let alignment: HorizontalAlignment

    static var `default`: Self {
        .init(spacing: nil, lineMinWidth: 4, alignment: .center)
    }
}

struct VerlicalLines<
    ID,
    Data: RandomAccessCollection,
    ColorResolver: LineColorResolver
>: View
    where Data: RandomAccessCollection, ID: Hashable, ID == ColorResolver.ID
{
    private let data: Data
    private let keyPath: KeyPath<Data.Element, ID>

    private let configuration: VerlicalLinesConfiguration

    private let resolver: ColorResolver

    @Environment(\.self)
    private var environment: EnvironmentValues

    var body: some View {
        VerlicalLinesLayout(spacing: spacing, barMinWidth: lineMinWidth, alignment: alignment) {
            let style = self.resolver.resolve(in: environment)

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
         style: ColorResolver)
    {
        self.data = data
        keyPath = id
        self.configuration = configuration
        resolver = style
    }

    init(_ data: Data,
         configuration: VerlicalLinesConfiguration = .default,
         style: ColorResolver)
        where Data.Element: Identifiable, Data.Element.ID == ID
    {
        self.init(data, id: \.id, configuration: configuration, style: style)
    }

    init(_ data: Data,
         configuration: VerlicalLinesConfiguration = .default,
         style: ColorResolver)
        where Data.Element: Hashable, Data.Element == ID
    {
        self.init(data, id: \.self, configuration: configuration, style: style)
    }
}

extension VerlicalLines where ColorResolver == GradientColorResolver<ID> {
    init(_ data: Data,
         id: KeyPath<Data.Element, ID>,
         configuration: VerlicalLinesConfiguration = .default,
         gradient: Gradient)
    {
        let style: ColorResolver = .init(gradient, count: data.count)
        self.init(data, id: id, configuration: configuration, style: style)
    }

    init(_ data: Data,
         configuration: VerlicalLinesConfiguration = .default,
         gradient: Gradient)
        where Data.Element: Identifiable, Data.Element.ID == ID
    {
        let style: ColorResolver = .init(gradient, count: data.count)
        self.init(data, configuration: configuration, style: style)
    }

    init(_ data: Data,
         configuration: VerlicalLinesConfiguration = .default,
         gradient: Gradient)
        where Data.Element: Hashable, Data.Element == ID
    {
        let style: ColorResolver = .init(gradient, count: data.count)
        self.init(data, configuration: configuration, style: style)
    }
}

extension VerlicalLines where ColorResolver == GradientColorResolver<ID> {
    init(_ data: Data, id: KeyPath<Data.Element, ID>, configuration: VerlicalLinesConfiguration = .default) {
        let style = GradientColorResolver<ID>(count: data.count)
        self.init(data, id: id, configuration: configuration, style: style)
    }

    init(_ data: Data, configuration: VerlicalLinesConfiguration = .default) where Data.Element: Identifiable, Data.Element.ID == ID {
        let style = GradientColorResolver<ID>(count: data.count)
        self.init(data, configuration: configuration, style: style)
    }

    init(_ data: Data, configuration: VerlicalLinesConfiguration = .default) where Data.Element: Hashable, Data.Element == ID {
        let style = GradientColorResolver<ID>(count: data.count)
        self.init(data, id: \.self, configuration: configuration, style: style)
    }
}

private extension VerlicalLines {
    var spacing: CGFloat? { configuration.spacing }
    var lineMinWidth: CGFloat? { configuration.lineMinWidth }
    var alignment: HorizontalAlignment { configuration.alignment }
}

private extension VerlicalLines {
    struct Line: View, Hashable {
        let color: Color
        let cornerRadius: CGFloat = 2

        var body: some View {
            GeometryReader { proxy in
                let size = proxy.size
                let radius = min(size.width, size.height) / 2
                color.cornerRadius(min(radius, cornerRadius))
            }
        }
    }
}

#Preview {
    let gradient = Gradient(colors: [.green, .red, .blue])

    VStack {
        VerlicalLines(0 ..< 21)

        VerlicalLines((0 ..< 64).shuffled())

        VerlicalLines(0 ..< 32, gradient: .systemRainbow)

        VerlicalLines((0 ..< 64).shuffled(), gradient: .systemRainbow)

        VerlicalLines(0 ..< 32, gradient: .systemRed)
        VerlicalLines((0 ..< 32).shuffled(), gradient: .systemMint)
    }
}

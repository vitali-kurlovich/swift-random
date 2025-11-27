//
//  ContentView.swift
//  SwiftRandom
//
//  Created by Vitali Kurlovich on 7.11.25.
//

import Charts
import Random
import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ColorBar: View, Equatable {
    let width: CGFloat
    let color: Color
    var body: some View {
        color.frame(width: width)
    }
}

struct Bar<ID: Hashable>: View {
    let id: ID
    let width: CGFloat
    let color: (ID) -> Color

    var body: some View {
        ColorBar(
            width: width,
            color: color(id)
        ).equatable()
    }
}

struct BarItem: Identifiable {
    let id: Int
}

extension BarItem {
    static func fill(_ range: Range<Int>) -> [Self] {
        range.map { .init(id: $0) }
    }
}

struct FaroShuffleBars: View {
    let model: FaroShuffleBarsModel

    let barWidth: CGFloat = 6

    var body: some View {
        HStack(spacing: 1) {
            ForEach(model.items) { item in
                Bar(id: item.id, width: barWidth) { id in
                    Color(hue: Double(id) / Double(model.itemsCount), saturation: 1, brightness: 1)
                }
            }
        }
    }
}

#Preview {
    // FaroShuffleBars(model: .init())
    FaroShuffleConfigurationView(model: .init())
}

struct VBars<Style: BarStyle> {
    let count: Int
    let style: Style
}

private extension VBars {
    func resolveColor(index: Int) -> Color {
        style.resolveColor(Double(index) / Double(count))
    }
}

protocol BarStyle {
    func resolveColor(_ offset: Double) -> Color
}

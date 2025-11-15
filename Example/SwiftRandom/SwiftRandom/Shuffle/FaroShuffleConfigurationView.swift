//
//  FaroShuffleConfigurationView.swift
//  SwiftRandom
//
//  Created by Vitali Kurlovich on 10.11.25.
//

import SwiftUI

struct FaroShuffleConfigurationView: View {
    let model: FaroShuffleBarsModel

    private var itemsCount: Binding<Double> {
        .init {
            Double(model.itemsCount)
        } set: { value, _ in
            model.itemsCount = Int(value)
        }
    }

    var body: some View {
        Form {
            Section(header: Text("Configuration")) {
                Slider(
                    value: itemsCount,
                    in: 1 ... 100,
                    step: 1
                ) {
                    Text("Count")
                }
                Text(model.itemsCount.formatted())
            }
        }
    }
}

#Preview {
    FaroShuffleConfigurationView(model: .init())
}

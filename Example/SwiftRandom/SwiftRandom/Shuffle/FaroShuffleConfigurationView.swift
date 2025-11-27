//
//  FaroShuffleConfigurationView.swift
//  SwiftRandom
//
//  Created by Vitali Kurlovich on 10.11.25.
//

import SwiftUI

struct FaroShuffleConfigurationView: View {
    let model: FaroShuffleBarsModel

    var body: some View {
        IntValueSlider("Count", in: 1 ... 100, value: itemsCount)
    }
}

private extension FaroShuffleConfigurationView {
    var itemsCount: Binding<Int> {
        .init {
            model.itemsCount
        } set: { value, _ in
            model.itemsCount = value
        }
    }
}

#Preview {
    Form {
        FaroShuffleConfigurationView(model: .init())
    }
}

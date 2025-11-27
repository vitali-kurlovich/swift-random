//
//  IntValueSlider.swift
//  SwiftRandom
//
//  Created by Vitali Kurlovich on 16.11.25.
//

import SwiftUI

struct IntValueSlider: View {
    @Binding var value: Int

    private let titleKey: LocalizedStringKey
    private let range: ClosedRange<Int>

    init(
        _ titleKey: LocalizedStringKey = "",
        in range: ClosedRange<Int>,
        value: Binding<Int>
    ) {
        self.titleKey = titleKey
        self.range = range
        _value = value
    }

    var body: some View {
        LabeledContent(titleKey, value: value.formatted())

        Slider(
            value: doubleValue,
            in: doubleRange,

            label: {},
            minimumValueLabel: {
                Text(range.lowerBound.formatted())
            },
            maximumValueLabel: {
                Text(range.upperBound.formatted())
            }
        )
    }
}

private extension IntValueSlider {
    var doubleValue: Binding<Double> {
        .init {
            Double(value)
        } set: { value, _ in
            self.value = .init(value)
        }
    }

    var doubleRange: ClosedRange<Double> {
        Double(range.lowerBound) ... Double(range.upperBound)
    }
}

#Preview {
    @Previewable @State var value = 0
    Form {
        IntValueSlider("Value", in: 5 ... 20, value: $value)
    }
}

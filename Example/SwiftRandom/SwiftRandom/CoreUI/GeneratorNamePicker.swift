//
//  GeneratorNamePicker.swift
//  SwiftRandom
//
//  Created by Vitali Kurlovich on 15.11.25.
//

import SwiftUI

enum RandomGenegatorName: String, CaseIterable, CustomStringConvertible, Identifiable {
    case mt19937
    case sha512

    var id: Self {
        self
    }

    var description: String {
        rawValue.capitalized
    }
}

struct GeneratorNamePicker: View {
    @Binding var generator: RandomGenegatorName

    private let titleKey: LocalizedStringKey

    init(
        _ titleKey: LocalizedStringKey = "Genegator",
        generator: Binding<RandomGenegatorName>
    ) {
        self.titleKey = titleKey
        _generator = generator
    }

    var body: some View {
        Picker(titleKey, selection: $generator) {
            ForEach(RandomGenegatorName.allCases) { generator in
                Text(generator.description).tag(generator)
            }
        }.pickerStyle(.menu)
    }
}

#Preview {
    @Previewable @State var generator = RandomGenegatorName.mt19937

    GeneratorNamePicker(generator: $generator)
}

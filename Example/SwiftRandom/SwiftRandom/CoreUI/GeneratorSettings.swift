//
//  GeneratorSettings.swift
//  SwiftRandom
//
//  Created by Vitali Kurlovich on 15.11.25.
//

import SwiftUI

struct GeneratorConfiguration: Hashable {
    var uuid: UUID
    var name: RandomGenegatorName
}

struct GeneratorSettings: View {
    @Binding var configuration: GeneratorConfiguration

    var body: some View {
        Group {
            GeneratorNamePicker("Type", generator: $configuration.name)

            UUIDField("Seed", uuid: $configuration.uuid)
        }
    }
}

#Preview {
    @Previewable @State var configuration = GeneratorConfiguration(uuid: .init(), name: .mt19937)
    Form {
        Section("Random Generator") {
            GeneratorSettings(configuration: $configuration)
        }

        Section("Items") {
            FaroShuffleConfigurationView(model: .init())
        }
    }
}

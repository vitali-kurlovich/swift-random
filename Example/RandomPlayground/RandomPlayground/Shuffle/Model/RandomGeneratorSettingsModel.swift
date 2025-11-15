//
//  RandomGeneratorSettingsModel.swift
//  RandomPlayground
//
//  Created by Vitali Kurlovich on 5.10.25.
//

import struct Foundation.UUID
import Observation
internal import UniformTypeIdentifiers

struct RandomGeneratorSettings: Hashable, Codable {
    var generator: Generator
    var uuid: UUID
}

extension RandomGeneratorSettings {
    enum Generator: String, Codable {
        case sha512
        case mt19937
    }

    init() {
        self.init(generator: .mt19937, uuid: UUID())
    }
}

@Observable
final class RandomGeneratorSettingsModel {
    var settings: RandomGeneratorSettings

    init(settings: RandomGeneratorSettings = .init()) {
        self.settings = settings
    }
}

import SwiftUI

struct UUIDView: View {
    @Binding var uuid: UUID

    var body: some View {
        buildControl()
    }

    private func buildControl() -> some View {
        Text(uuid.uuidString)
            .textSelection(.enabled)
            .padding(8)
            .glassEffect()
            .focusable()
    }

    @ViewBuilder
    private func buildBody() -> some View {
        #if os(macos)
            buildControl()

        #else
            buildControl()
        #endif
    }

    func past() {
        UIPasteboard.changedNotification
    }
}

struct RandomGeneratorSettingsView: View {
    let model: RandomGeneratorSettingsModel

    @State
    var uuidText: String {
        didSet {
            print(uuidText)
        }
    }

    init(model: RandomGeneratorSettingsModel) {
        self.model = model
        uuidText = model.settings.uuid.uuidString
    }

    var body: some View {
        UUIDView(uuid: .init(get: {
            model.settings.uuid
        }, set: { uuid in
            model.settings.uuid = uuid
        }))
    }
}

#Preview {
    @State var text = ""

    VStack(alignment: .leading, spacing: 16) {
        RandomGeneratorSettingsView(model: .init())

        TextField(
            "Text field",
            text: $text
        )
        .textFieldStyle(.roundedBorder)
    }
    .padding()
}

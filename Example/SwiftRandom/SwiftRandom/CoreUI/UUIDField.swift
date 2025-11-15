//
//  UUIDField.swift
//  SwiftRandom
//
//  Created by Vitali Kurlovich on 10.11.25.
//

import SwiftUI

struct UUIDField: View {
    @Binding var uuid: UUID
    @StateObject private var pasteboardWatcher = PasteboardWatcher()

    private let titleKey: LocalizedStringKey

    init(
        _ titleKey: LocalizedStringKey = "UUID",
        uuid: Binding<UUID>
    ) {
        self.titleKey = titleKey
        _uuid = uuid
    }

    var body: some View {
        LabeledContent(titleKey) {
            ViewThatFits(in: .horizontal) {
                HStack {
                    buildText()
                    buildNewButton()
                }

                HStack {
                    buildText()
                    buildNewButton(.textOnly)
                }
            }
        }
    }
}

private extension UUIDField {
    func buildText() -> some View {
        Text(uuid.uuidString)
            .font(.default.monospaced(true))
            .lineLimit(1)
            .focusable()
            .contextMenu {
                buildNewButton()
                Divider()
                pastboardMenuItems()
            }
        #if os(macos)
            .copyable([uuid])
            .pasteDestination(for: UUID.self) { uuids in
                guard let uuid = uuids.first else { return }
                self.uuid = uuid
            }
        #endif // os(macos)
    }

    @ViewBuilder
    func pastboardMenuItems() -> some View {
        Button {
            pasteboardWatcher.uuid = uuid
        } label: {
            Label("Copy", systemImage: "document.on.document")
        }

        PasteButton(payloadType: UUID.self) { uuids in
            if let uuid = uuids.first {
                self.uuid = uuid
            }
        }.disabled(pasteboardWatcher.uuid == nil)
    }
}

private extension UUIDField {
    enum ButtonLabel {
        case `default`
        case iconOnly
        case textOnly
    }

    func buildNewButton(_ style: ButtonLabel = .default) -> some View {
        Button {
            uuid = UUID()
        } label: {
            switch style {
            case .default:
                buttonLabelText()
                buttonLabelImage()

            case .iconOnly:
                buttonLabelImage()

            case .textOnly:
                buttonLabelText()
            }
        }
        .buttonStyle(.borderedProminent)
    }

    func buttonLabelText() -> Text {
        Text("New")
    }

    func buttonLabelImage() -> Image {
        Image(systemName: "sparkles.2")
    }
}

#Preview {
    @Previewable @State var uuid = UUID()

    UUIDField(uuid: $uuid)
}

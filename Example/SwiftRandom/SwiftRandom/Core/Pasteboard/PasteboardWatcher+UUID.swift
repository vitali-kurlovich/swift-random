//
//  PasteboardWatcher+UUID.swift
//  SwiftRandom
//
//  Created by Vitali Kurlovich on 15.11.25.
//

import struct Foundation.UUID

extension PasteboardWatcher {
    var uuid: UUID? {
        get {
            pasteboard.uuid
        }

        set {
            pasteboard.uuid = newValue
        }
    }
}

//
//  UUID+seed.swift
//  swift-random
//
//  Created by Vitali Kurlovich on 4.04.25.
//

import struct Foundation.UUID

extension UUID {
    @usableFromInline
    var seed: UInt64 {
        let uuid = self.uuid
        let bytes: [UInt8] = [
            uuid.0,
            uuid.1,
            uuid.2,
            uuid.3,
            uuid.4,
            uuid.5,
            uuid.6,
            uuid.7,
            uuid.8,
            uuid.9,
            uuid.10,
            uuid.11,
            uuid.12,
            uuid.13,
            uuid.14,
            uuid.15,
        ]

        var first: UInt64 = 0
        var second: UInt64 = 0

        bytes.withUnsafeBytes {
            first = $0.baseAddress!.load(as: UInt64.self)
            second = $0.baseAddress!.load(fromByteOffset: 8, as: UInt64.self)
        }

        return first ^ second
    }
}

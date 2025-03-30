//
//  FastRandomGenegator.swift
//  swift-random
//
//  Created by Vitali Kurlovich on 30.03.25.
//

import Foundation

public struct FastRandomGenegator: RandomNumberGenerator {
    private var x: UInt64 = 0

    public init(seed: UInt64) {
        x = Self.next(for: seed)
    }

    public
    mutating func next() -> UInt64 {
        let prev = Self.next(for: x)
        x = Self.next(for: x)
        let next = Self.next(for: x)
        x = next
        return prev ^ (next << (64 - 48))
    }
}

public
extension FastRandomGenegator {
    init(uuid: UUID = UUID()) {
        let seed = Self.seed(from: uuid)
        self.init(seed: seed)
    }
}

private
extension FastRandomGenegator {
    static var a: UInt64 { 0x5_DEEC_E66D }
    static var c: UInt64 { 0xB }

    static var m: UInt64 { 0x2 << 48 }

    static func next(for x: UInt64) -> UInt64 {
        x.multipliedReportingOverflow(by: a)
            .partialValue
            .addingReportingOverflow(c)
            .partialValue % m
    }

    static func seed(from: UUID) -> UInt64 {
        let uuid = from.uuid
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
            let from = $0.baseAddress!
            memcpy(&first, from, 8)
            memcpy(&second, from + 8, 8)
        }

        return first.littleEndian ^ second.littleEndian
    }
}

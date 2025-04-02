//
//  Ranlux48RandomGenegator.swift
//  swift-random
//
//  Created by Vitali Kurlovich on 30.03.25.
//

import Foundation

public struct Ranlux48RandomGenegator: RandomNumberGenerator {
    private var state: rand48_state_t

    private init(state: rand48_state_t) {
        self.state = state
    }

    public init(seed: UInt64) {
        var state: rand48_state_t = .init(x0: 0, x1: 0, x2: 0)
        rand48_set(state: &state, s: seed)
        self.init(state: state)
    }

    public
    mutating func next() -> UInt64 {
        var state = self.state

        let prev = rand48_get(state: &state)
        let next = rand48_get(state: &state)

        self.state = state

        return prev ^ (next << 32)
    }
}

public
extension Ranlux48RandomGenegator {
    init(uuid: UUID = UUID()) {
        let seed = Self.seed(from: uuid)
        self.init(seed: seed)
    }
}

private
extension Ranlux48RandomGenegator {
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

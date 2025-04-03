//
//  Ranlux48RandomGenegator.swift
//  swift-random
//
//  Created by Vitali Kurlovich on 30.03.25.
//

import struct Foundation.UUID

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
        self.init(seed: uuid.seed)
    }
}

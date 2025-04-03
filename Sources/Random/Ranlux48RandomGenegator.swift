//
//  Ranlux48RandomGenegator.swift
//  swift-random
//
//  Created by Vitali Kurlovich on 30.03.25.
//

import struct Foundation.UUID

public struct Ranlux48RandomGenegator: RandomNumberGenerator {
    private var state = rand48_state_t()

    public init(seed: UInt64) {
        state.rand48_set(s: seed)
    }

    public
    mutating func next() -> UInt64 {
        let prev = state.rand48_get()
        let next = state.rand48_get()
        return prev ^ (next << 32)
    }
}

public
extension Ranlux48RandomGenegator {
    init(uuid: UUID = UUID()) {
        self.init(seed: uuid.seed)
    }
}

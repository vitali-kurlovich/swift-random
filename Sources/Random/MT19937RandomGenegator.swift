//
//  MT19937RandomGenegator.swift
//  swift-random
//
//  Created by Vitali Kurlovich on 4.04.25.
//

import struct Foundation.UUID

public struct MT19937RandomGenegator: RandomNumberGenerator {
    private var state = mt_state_t()

    public init(seed: UInt64) {
        state.mt_set(s: UInt32(seed: seed))
    }

    public
    mutating func next() -> UInt64 {
        let prev = UInt64(state.mt_get())
        let next = UInt64(state.mt_get())
        return (prev << 32) ^ next
    }
}

public
extension MT19937RandomGenegator {
    init(uuid: UUID = UUID()) {
        self.init(seed: uuid.seed)
    }
}

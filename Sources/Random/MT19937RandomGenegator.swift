//
//  MT19937RandomGenegator.swift
//  swift-random
//
//  Created by Vitali Kurlovich on 4.04.25.
//

import struct Foundation.UUID

public struct MT19937RandomGenegator: RandomNumberGenerator {
    @usableFromInline var state = mt_state_t()

    public init(seed: UInt64) {
        state.mt_set(s: UInt32(seed: seed))
    }

    @inlinable
    public mutating func next() -> UInt64 {
        return state.mt_get64()
    }
}

public extension MT19937RandomGenegator {
    init(uuid: UUID = UUID()) {
        self.init(seed: uuid.seed)
    }
}

//
//  MT19937RandomGenegator.swift
//  swift-random
//
//  Created by Vitali Kurlovich on 4.04.25.
//

import struct Foundation.UUID

public struct MT19937RandomGenegator: RandomNumberGenerator {
    @usableFromInline var state = mt19937_state()

    public init(seed: UInt32) {
        state.mt_set(s: seed)
    }

    @inlinable
    public mutating func next() -> UInt64 {
        return state.mt_get64()
    }
}

public extension MT19937RandomGenegator {
    init(uuid: UUID = UUID()) {
        self.init(seed: UInt32(seed: uuid.seed))
    }
}

public struct MT19937_64_RandomGenegator: RandomNumberGenerator {
    @usableFromInline var state: mt19937_64

    public init(seed: UInt64 = 5489) {
        state = .init(seed: seed)
    }

    @inlinable
    public mutating func next() -> UInt64 {
        return state.rand()
    }
}
